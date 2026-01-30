// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/quick_transfer/nfc_helper.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';

class NfcReaderScreen extends ConsumerStatefulWidget {
  const NfcReaderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NfcReaderScreenState();
}

class _NfcReaderScreenState extends ConsumerState<NfcReaderScreen> {
  String _statusMessage = 'Tap the button to start reading.';
  String _readData = '';
  bool _isReading = false;

  Future<void> _readNfcCard() async {
    setState(() {
      _statusMessage = 'Hold your card near the device.';
      _readData = '';
      _isReading = true;
    });

    try {
      final tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 20),
      );
      if (tag.type == NFCTagType.mifare_ultralight) {
        try {
          var stringBuffer = StringBuffer();
          for (int page = 4; page < 40; page += 4) {
            final pageHex = page.toRadixString(16).padLeft(2, '0');
            final command = '30$pageHex';

            final result = await FlutterNfcKit.transceive(
              command,
              timeout: const Duration(seconds: 1),
            );
            stringBuffer.write(result);
          }
          final fullDataString = stringBuffer.toString();
          final convertedData = convertHexToData(fullDataString);
          debugPrintDev('MIFARE Ultralight Full Data: $fullDataString');
          debugPrintDev('Decoded Data: $convertedData');
          setState(() {
            _readData = 'NFC Card Data:\n$convertedData';
            _statusMessage = 'NFC Tag Read Successfully!';
          });
          ref
              .read(posCardPurchaseProvider.notifier)
              .submitNfcPurchase(context: context, payLoad: convertedData);
        } catch (e) {
          setState(() {
            _statusMessage = 'Failed to read NFC tag';
            _readData = '';
          });
        }
      } else {
        setState(() {
          _readData = "NFC Card not supported: ${tag.type}";
          _statusMessage = 'Unsupported Card Type';
        });
      }
    } on Exception catch (_) {
      setState(() {
        _statusMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isReading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      isLoading: ref.watch(posCardPurchaseProvider).isLoading,
      appBar: AppbarSubScreen(title: 'Pay With NFC'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            /*const SizedBox(height: 24),
            if (_readData.isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.lightBlue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Read Data:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_readData, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),*/
            const SizedBox(height: 24),
            if (!_isReading)
              ElevatedButton.icon(
                onPressed: _readNfcCard,
                icon: const Icon(Icons.nfc),
                label: const Text('Read NFC Card'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            else
              Center(child: const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
