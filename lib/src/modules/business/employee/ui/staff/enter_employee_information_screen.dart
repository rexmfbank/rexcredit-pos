import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmployeePersonalInformationScreen extends StatefulHookConsumerWidget {
  const EmployeePersonalInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeePersonalInformationScreenState();
}

class _EmployeePersonalInformationScreenState
    extends ConsumerState<EmployeePersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firstnameController = useTextEditingController();
    final lastnameController = useTextEditingController();
    final emailController = useTextEditingController();

    return Scaffold(
      appBar: const RexAppBar(
        step: '1/4',
        shouldHaveBackButton: true,
        title: StringAssets.employeePersonalInfoTitle,
        subtitle: StringAssets.employeePersonalInfoSubtitle,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            RexTextField(
              outerTitle: 'First Name *',
              hintText: StringAssets.firstNameHint,
              controller: firstnameController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter employee firstname';
                }
                return null;
              },
            ),
            RexTextField(
              outerTitle: 'Last Name *',
              hintText: 'Enter Last Name',
              controller: lastnameController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter employee lastname';
                }
                return null;
              },
            ),
            RexTextField(
              outerTitle: 'Email Address *',
              hintText: 'Business@example.co',
              controller: emailController,
              obscureText: false,
              inputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter employee email';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    context.push(
                        '${Routes.dashboardBusiness}/${Routes.employeeWorkInformation}');
                  }
                },
                buttonTitle: StringAssets.nextTextOnButton,
                backgroundColor: _formKey.currentState?.validate() == true
                    ? null
                    : AppColors.cardGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
