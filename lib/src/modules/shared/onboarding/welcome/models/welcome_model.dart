import 'package:flutter/material.dart' show Color;
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:equatable/equatable.dart';

class WelcomeModel extends Equatable {
  final Color color;
  final String imagePath;
  final String titleText;
  final String titleIconPath;
  final String descriptionText;

  const WelcomeModel({
    required this.color,
    required this.imagePath,
    required this.titleText,
    required this.titleIconPath,
    required this.descriptionText,
  });

  @override
  List<Object?> get props => [
        color,
        imagePath,
        titleText,
        titleIconPath,
        descriptionText,
      ];
}

List<WelcomeModel> welcomePages = const [
  WelcomeModel(
    color: Color(0xffAFCDFB),
    imagePath: AssetPath.welcomeImage1,
    titleText: StringAssets.welcomeTitle1,
    titleIconPath: AssetPath.welcomeIcon1,
    descriptionText: StringAssets.welcomeDescription1,
  ),
  WelcomeModel(
    color: Color(0xffDD89A2),
    imagePath: AssetPath.welcomeImage2,
    titleText: StringAssets.welcomeTitle2,
    titleIconPath: AssetPath.welcomeIcon2,
    descriptionText: StringAssets.welcomeDescription2,
  ),
  WelcomeModel(
    color: Color(0xffC6DCFE),
    imagePath: AssetPath.welcomeImage3,
    titleText: StringAssets.welcomeTitle3,
    titleIconPath: AssetPath.welcomeIcon3,
    descriptionText: StringAssets.welcomeDescription3,
  ),
  WelcomeModel(
    color: Color(0xff143DA5),
    imagePath: AssetPath.welcomeImage4,
    titleText: StringAssets.welcomeTitle4,
    titleIconPath: AssetPath.welcomeIcon4,
    descriptionText: StringAssets.welcomeDescription4,
  ),
];
