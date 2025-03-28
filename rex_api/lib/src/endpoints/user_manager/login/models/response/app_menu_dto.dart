import 'package:rex_api/src/utils/enums/app_menu_type.dart';

class AppMenuDto {
  final AppMenuType? menuCode;
  final String? message;
  final bool status;

  AppMenuDto({
    this.menuCode,
    this.message,
    this.status = true,
  });

  factory AppMenuDto.fromJson(Map<String, dynamic> json) => AppMenuDto(
    menuCode: (json["menuCode"] as String?).jsonAppMenuType,
    message: json["message"],
    status: json["status"],
  );
}
