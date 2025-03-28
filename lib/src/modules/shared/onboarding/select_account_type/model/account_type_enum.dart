// ignore_for_file: constant_identifier_names

import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

enum AccountTypeEnum {
  INDIVIDUAL(
    title: 'Individual',
    subTitle: 'Create an individual profile',
    kycText: StringAssets.kycIndividual,
  ),
  SOLE_PROPRIETORSHIP(
    title: 'Sole Proprietorship',
    subTitle: 'Create a business profile for a Sole Proprietor',
    kycText: StringAssets.kycSoleProprietor,
  ),
  LIMITED_LIABILITY(
    title: 'Limited Liability Company',
    subTitle: 'Create a business profile for a Limited Liability Company',
    kycText: StringAssets.kycLimitiedLiability,
  ),
  PARTNERSHIP(
    title: 'Partnership',
    subTitle: 'Create a business profile for a Partnership',
    kycText: StringAssets.kycPartnership,
  ),
  COOPERATIVE(
    title: 'Cooperative Society',
    subTitle: 'Create a business profile for a Cooperative Society',
    kycText: StringAssets.kycCooperative,
  );

  final String title;
  final String subTitle;
  final String kycText;

  const AccountTypeEnum({
    required this.title,
    required this.subTitle,
    required this.kycText,
  });
}

class AccountType {
  String title;
  String subtitle;
  String imagePath;
  bool isSelected;
  String kycText;

  AccountType({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isSelected,
    required this.kycText,
  });

  @override
  String toString() => {
        "CLASS": "AccountType",
        "title": title,
        "subtitle": subtitle,
        "imagePath": imagePath,
        "isSelected": isSelected,
        "kycText": kycText,
      }.toString();
}

List<AccountType> accountTypeList2 = [
  AccountType(
    title: AccountTypeEnum.INDIVIDUAL.title,
    subtitle: AccountTypeEnum.INDIVIDUAL.subTitle,
    kycText: AccountTypeEnum.INDIVIDUAL.kycText,
    imagePath: AssetPath.accountType1,
    isSelected: false,
  ),
  AccountType(
    title: AccountTypeEnum.SOLE_PROPRIETORSHIP.title,
    subtitle: AccountTypeEnum.SOLE_PROPRIETORSHIP.subTitle,
    kycText: AccountTypeEnum.SOLE_PROPRIETORSHIP.kycText,
    imagePath: AssetPath.accountType2,
    isSelected: false,
  ),
  AccountType(
    title: AccountTypeEnum.COOPERATIVE.title,
    subtitle: AccountTypeEnum.COOPERATIVE.subTitle,
    kycText: AccountTypeEnum.COOPERATIVE.kycText,
    imagePath: AssetPath.accountType2,
    isSelected: false,
  ),
  AccountType(
    title: AccountTypeEnum.PARTNERSHIP.title,
    subtitle: AccountTypeEnum.PARTNERSHIP.subTitle,
    kycText: AccountTypeEnum.PARTNERSHIP.kycText,
    imagePath: AssetPath.accountType2,
    isSelected: false,
  ),
  AccountType(
    title: AccountTypeEnum.LIMITED_LIABILITY.title,
    subtitle: AccountTypeEnum.LIMITED_LIABILITY.subTitle,
    kycText: AccountTypeEnum.LIMITED_LIABILITY.kycText,
    imagePath: AssetPath.accountType2,
    isSelected: false,
  ),
];

List<AccountType> accountTypeList = [
  AccountType(
    title: 'Individual',
    subtitle: 'Create an individual profile',
    imagePath: AssetPath.accountType1,
    isSelected: false,
    kycText: '',
  ),
  AccountType(
    title: 'Business',
    subtitle: 'Create a business profile',
    imagePath: AssetPath.accountType2,
    isSelected: false,
    kycText: '',
  ),
];
