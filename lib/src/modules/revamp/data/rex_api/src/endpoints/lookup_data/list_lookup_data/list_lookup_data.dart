import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../utils/api_path.dart';

mixin ListLookupData {
  Future<dynamic> listLookupData({
    required String lookupCode,
    required String entityCode,
    required String parentCode,
  }) async {
    try {
      final dio =
          Dio()
            ..interceptors.add(
              PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
                compact: false,
              ),
            );
      final response = await dio.get(
        ApiPath.listLookupData(lookupCode, entityCode, parentCode),
        options: Options(headers: ApiHeaders.headerNoTokenI),
      );

      return response.data;
    } catch (e, _) {
      throw RexApiException.incompleteProcess();
    }
  }
}
