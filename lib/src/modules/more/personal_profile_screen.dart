import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/utils/general/app_text_validator.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/shared/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PersonalProfileScreen extends ConsumerWidget {
  const PersonalProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: Strings.emptyString,
        title: Strings.personalInfoTitle,
        subtitle: Strings.personalInfoSubtitle,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          Card(
            margin: EdgeInsets.all(16.0.ar),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0.ar),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.ah),
              child: Column(
                children: [
                  //ProfileImageWidget(imageUrl: ''),
                  SizedBox(height: 16.ah),
                  ProfileText(title: Strings.firstNameTitle, value: ''),
                  ProfileText(title: Strings.middleNameTitle, value: ''),

                  ProfileText(
                    title: Strings.lastNameTitle,
                    value: "data.lastname",
                  ),
                  ProfileText(
                    title: Strings.emailAddressTitle,
                    value: "data.email",
                  ),
                  ProfileText(
                    title: Strings.phoneNumberTitle,
                    value: "mobile-no",
                  ),
                  ProfileText(title: Strings.dateOfBirthTitle, value: ""),
                  ProfileText(title: Strings.gender, value: "data.gender"),
                  ProfileText(
                    title: Strings.addressTitle,
                    value: "data.address",
                  ),
                  //const CustomerProfileTier(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileText extends StatelessWidget {
  final String title;
  final String value;
  final bool isEditable;

  const ProfileText({
    super.key,
    required this.title,
    required this.value,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.ah, horizontal: 24.0.aw),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(color: AppColors.rexPurpleLight),
            ),
          ),
          SizedBox(width: 10.aw),
          Expanded(
            flex: isEditable ? 2 : 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.visible,
            ),
          ),
          isEditable
              ? Expanded(
                flex: 1,
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit_square,
                      color: AppColors.rexPurpleDark3,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;

  const ProfileImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120.0.aw,
        height: 120.0.ah,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.rexLightBlue, width: 4.0.ar),
        ),
        child: ClipOval(
          child: Image.network(
            imageUrl,
            width: 50.0.aw,
            height: 50.0.ah,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.person, size: 100.ar);
            },
          ),
        ),
      ),
    );
  }
}

class MiddlenameField extends StatefulWidget {
  final String initialMiddlename;
  final Function(String) onSave;

  const MiddlenameField({
    super.key,
    required this.initialMiddlename,
    required this.onSave,
  });

  @override
  State<StatefulWidget> createState() => _MiddlenameFieldState();
}

class _MiddlenameFieldState extends State<MiddlenameField> {
  bool _isEditing = false;
  late TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialMiddlename);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveMiddlename() {
    setState(() {
      widget.onSave(_controller.text);
      _toggleEditing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.ah, horizontal: 24.0.aw),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                Strings.middleNameTitle,
                style: TextStyle(color: AppColors.rexPurpleLight),
              ),
            ),
            SizedBox(width: 10.aw),
            widget.initialMiddlename.isEmpty
                ? _isEditing
                    ? Flexible(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: RexTextField(
                              controller: _controller,
                              hintText: Strings.middleNameHint,
                              backgroundColor: AppColors.rexBackground,
                              validator:
                                  (value) => AppTextValidator.name(value),
                              onEditingComplete: _saveMiddlename,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: const Icon(
                                Icons.check,
                                color: AppColors.rexPurpleDark3,
                              ),
                              onPressed: _saveMiddlename,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: _toggleEditing,
                        child: const Text(
                          Strings.addMiddlename,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                : Expanded(
                  flex: 3,
                  child: Text(
                    widget.initialMiddlename,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.visible,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
