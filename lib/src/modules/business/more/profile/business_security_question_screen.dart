import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/store_security_question_api_provider.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/components/security_question_dropdown.dart';
import 'package:rex_app/src/modules/individual/more/provider/more_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_error_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class BusinessSecurityQuestionScreen extends StatefulHookConsumerWidget {
  const BusinessSecurityQuestionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessSecurityQuestionScreenState();
}

class _BusinessSecurityQuestionScreenState
    extends ConsumerState<BusinessSecurityQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  void loadingInit() {
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
  }

  @override
  Widget build(BuildContext context) {
    final answerController = useTextEditingController();
    final selectedQuestion = ref.watch(securityQuestionProvider);

    //
    loadingInit();
    //

    return AppScaffold(
      padding: EdgeInsets.symmetric(horizontal: 13.aw),
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.securityQuestionTitle,
        subtitle: StringAssets.securityQuestionSubtitle,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10.ah),
            const SecurityQuestionDropdown(padding: EdgeInsets.zero),
            SizedBox(height: 10.ah),
            RexTextField(
              horizontalPadding: 0,
              outerTitle: StringAssets.securityAnswer,
              showOuterTile: true,
              hintText: StringAssets.emptyString,
              controller: answerController,
              obscureText: false,
            ),
            SizedBox(height: 24.ah),
            RexFlatButton(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    answerController.text.isNotBlank &&
                    selectedQuestion.name.isNotBlank) {
                  final question = StoreSecurityQuestionRequest(
                    question: selectedQuestion.name,
                    answer: answerController.text.toString(),
                  );
                  ref
                      .read(storeSecurityQuestionApiProvider.notifier)
                      .setupSecurityQuestion(request: question);
                  return;
                }
                showModalActionError(
                  context: context,
                  title: StringAssets.validationError,
                  errorText: StringAssets.pleaseFillAllFields,
                );
              },
              buttonTitle: StringAssets.saveText,
              backgroundColor: null,
            ),
          ],
        ),
      ),
    );
  }
}
