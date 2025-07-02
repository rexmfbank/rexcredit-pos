import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/store_security_question_api_provider.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/components/security_question_dropdown.dart';
import 'package:rex_app/src/modules/individual/more/provider/more_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_error_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SecurityQuestionScreen extends StatefulHookConsumerWidget {
  const SecurityQuestionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecurityQuestionScreenState();
}

class _SecurityQuestionScreenState
    extends ConsumerState<SecurityQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final answerController = useTextEditingController();
    //
    final selectedQuestion = ref.watch(securityQuestionProvider);
    //
    ref.listen(
      storeSecurityQuestionApiProvider,
      (_, state) {
        state.when(
          data: (data) {
            LoadingScreen.instance().hide();
            ref.read(verifiedSecurityQuestionProvider.notifier).state = true;
            showSuccessModal(
              context,
              StringAssets.securityQuestionAdded,
              StringAssets.successDescription,
              StringAssets.ok,
              'success_tick',
              () {
                context.pop();
                context.pop();
              },
            );
          },
          error: (error, stackTrace) {
            LoadingScreen.instance().hide();
            showRexErrorDialog(
              context: context,
              errorText: error.toString(),
            );
          },
          loading: () {
            LoadingScreen.instance().show(context: context);
          },
        );
      },
    );
    //
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.securityQtitle,
        subtitle: StringAssets.securityQsubtitle,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SecurityQuestionDropdown(),
            RexTextField(
              outerTitle: StringAssets.securityAnswer,
              showOuterTile: true,
              hintText: StringAssets.securityAnswer,
              controller: answerController,
              obscureText: false,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 32.0,
              ),
              child: RexElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final question = StoreSecurityQuestionRequest(
                        question: selectedQuestion.name,
                        answer: answerController.text.toString());

                    ref
                        .read(storeSecurityQuestionApiProvider.notifier)
                        .setupSecurityQuestion(request: question);
                  }
                },
                buttonTitle: StringAssets.confirmTextOnButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
