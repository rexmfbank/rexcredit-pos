import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

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
