import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/more/providers/request_pos_state_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DirectorIDVerificationScreen extends HookConsumerWidget {
  const DirectorIDVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idController = useTextEditingController();

    return Scaffold(
        appBar: const RexAppBar(
          step: null,
          shouldHaveBackButton: true,
          title: StringAssets.directorIdVerificationTitle,
          subtitle: StringAssets.directorIdVerificationSubtitle2,
          hasActionButton: false,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 16),
            RexCustomSpinner(options: [], title: StringAssets.idCardType),
            const SizedBox(height: 16),
            RexTextField(
                outerTitle: StringAssets.identityCardNumber,
                showOuterTile: true,
                hintText: StringAssets.enterIdNumber,
                controller: idController,
                inputType: TextInputType.number,
                obscureText: false),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: Text(
                StringAssets.uploadImageId,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  ref.read(directorIDProvider.notifier).state = true;
                  context.pop();
                },
                buttonTitle: StringAssets.saveAndContinueText,
                backgroundColor: null,
              ),
            ),
          ],
        ));
  }
}
