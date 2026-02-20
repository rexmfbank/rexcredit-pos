import 'package:rex_app/src/modules/revamp/api/rex_api.dart';

class RexApi with PosApi {
  RexApi._();

  static final RexApi _instance = RexApi._();

  static RexApi get instance => _instance;
}
