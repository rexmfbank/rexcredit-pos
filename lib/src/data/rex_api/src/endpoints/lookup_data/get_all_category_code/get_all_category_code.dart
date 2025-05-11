import 'package:dio/dio.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../utils/api_path.dart';

mixin GetAllCategoryCode {
  Future<dynamic> getAllCategoryCode({
    required String categoryCode,
  }) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        ApiPath.getAllCategoryCode(categoryCode),
        options: Options(headers: ApiHeaders.requestHeader),
      );

      return response.data;
    } catch (e, stackTrace) {
      print("Error => ${e.toString()}");
      print("Error Stack => $stackTrace");
      throw RexApiException.incompleteProcess();
    }
  }
}
