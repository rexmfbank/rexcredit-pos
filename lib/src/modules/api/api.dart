import 'package:rex_app/src/modules/api/endpoints/login_endpoints.dart';
import 'package:rex_app/src/modules/api/endpoints/pos_endpoints.dart';
import 'package:rex_app/src/modules/api/endpoints/transfer_endpoints.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

class RexApi with PosEndpoints, LoginEndpoints, TransferEndpoints {
  RexApi._();

  static final RexApi _instance = RexApi._();

  static RexApi get instance => _instance;
}
