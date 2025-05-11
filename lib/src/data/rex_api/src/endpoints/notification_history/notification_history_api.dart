import 'package:dio/dio.dart';
import 'request/get_push_notifications_query.dart';
import 'request/update_notification_request.dart';
import 'response/get_notifications_response.dart';
import '../shared_models/api_headers.dart';
import '../utility/response/rex_response_template.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../exceptions/string_constants.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';

mixin NotificationHistoryApi{
  static final _tokenProvider = AppNetworkProvider();

  Future<GetNotificationsResponse> getNotificationHistory({
    required String authToken, required GetNotificationsQuery query,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getAllNotifications,
      method: RequestMethod.get,
      queryParams: query.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => GetNotificationsResponse.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<RexResponseTemplate> updateNotificationStatus({
    required String authToken, required UpdateNotificationRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.updateNotificationStatus,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => RexResponseTemplate.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? (res.right.responseCode ?? '') : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<RexResponseTemplate> deleteNotifications({required String authToken})async{
    final response = await _tokenProvider.call(
      path: ApiPath.getAllNotifications,
      method: RequestMethod.delete,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => RexResponseTemplate.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? (res.right.responseCode ?? '') : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}