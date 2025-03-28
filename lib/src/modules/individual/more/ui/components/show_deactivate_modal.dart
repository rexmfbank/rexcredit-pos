import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/provider/deactivate_account_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

showDeactivateModal({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final deactivateState = ref.watch(deactivateAccountProvider);
          //
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Column(
                children: [
                  const Flexible(
                    child: Text(
                      StringAssets.deactivateTitle,
                      style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Flexible(
                    child: Text(
                      StringAssets.deactivateSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Flexible(
                    child: deactivateState.isLoading
                        ? const _Loading()
                        : Text(
                            deactivateState.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.rexGreen,
                            ),
                          ),
                  ),
                  const SizedBox(height: 6.0),
                  RexElevatedButton(
                    onPressed: () {
                      ref
                          .read(deactivateAccountProvider.notifier)
                          .deactivate(context);
                    },
                    buttonTitle: deactivateState.isSuccess == null
                        ? 'I understand, deactivate'
                        : 'Done',
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: AppColors.rexPurpleLight,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text(
          'Please wait',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
