import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../exceptions/data_transformer.dart';
import '../exceptions/error_code.dart';
import '../exceptions/ground_exception.dart';
import '../exceptions/response_exceptions.dart';
import '../exceptions/rex_api_exception.dart';
import 'interceptors.dart';
import 'package:either_dart/either.dart';

const bool _showLogs = kDebugMode;

class AppNetworkProvider {
  Dio getDioInstance() {
    var dio = Dio(BaseOptions(
      connectTimeout: Duration(milliseconds: 50000),
      receiveTimeout: Duration(milliseconds: 50000),
    ));
    //dio.interceptors.add(AppInterceptor());
    dio.interceptors.addAll([AppInterceptor(), ConnectivityInterceptor()]);

    if (_showLogs) {
      ///This [LogInterceptor] does not properly log all the response from API
      ///some logs are cutoff that is why I am changing it to [PrettyDioLogger]
      dio.interceptors.add(PrettyDioLogger(
        responseBody: _showLogs,
        error: _showLogs,
        request: _showLogs,
        requestBody: _showLogs,
        requestHeader: _showLogs,
        responseHeader: _showLogs,
      ));
    }

    return dio;
  }

  AppNetworkProvider();

  Future<Either<RexApiException, Response?>> call({
    required String path,
    required RequestMethod method,
    dynamic body = const {},
    Map<String, dynamic> queryParams = const {},
    Options? options,
    Function(double)? onSendProgress,
  }) async {
    Response? response;
    try {
      switch (method) {
        case RequestMethod.get:
          response = await getDioInstance().get(
            path,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case RequestMethod.post:
          response = await getDioInstance().post(
            path,
            data: body,
            queryParameters: queryParams,
            options: options,
            onSendProgress: (sent, total) => onSendProgress,
          );
          break;
        case RequestMethod.patch:
          response = await getDioInstance().patch(
            path,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case RequestMethod.put:
          response = await getDioInstance().put(
            path,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case RequestMethod.delete:
          response = await getDioInstance().delete(
            path,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
      }
      return Right(response);
    } on SocketException catch (e, _) {
      return Left(RexApiException(message: "Internet connection lost"));
    } on DioException catch (e, stackTrace) {
      debugPrint("Error => ${e.toString()}");
      debugPrint("Error Stack => $stackTrace");
      final error = transformObject(e, ((p0) => ResponseException.fromDio(p0)));
      if (error.isLeft) return Left(error.left);
      return Left(error.right);
    } on Exception catch (e, stackTrace) {
      debugPrint("Error => ${e.toString()}");
      debugPrint("Error Stack => $stackTrace");
      return Left(GroundException(e.toString()));
    }
  }

  Future<Either<RexApiException, Response?>> download({
    required String path,
    required String savePath,
    Options? options,
    Function(double)? onReceiveProgress,
  }) async {
    Response? response;

    try {
      response = await getDioInstance().download(
        path,
        savePath,
        options: options,
        onReceiveProgress: (sent, total) => onReceiveProgress,
      );
      return Right(response);
    } on DioException catch (e, stackTrace) {
      debugPrint("Error => ${e.toString()}");
      debugPrint("Error Stack => $stackTrace");
      final error = transformObject(e, ((p0) => ResponseException.fromDio(p0)));
      if (error.isLeft) return Left(error.left);
      return Left(error.right);
    } on Exception catch (e, stackTrace) {
      debugPrint("Error => ${e.toString()}");
      debugPrint("Error Stack => $stackTrace");
      return Left(GroundException(e.toString()));
    }
  }

  void parseResponse({
    required String responseCode,
    VoidCallback? resultAction,
    VoidCallback? errorAction,
  }) {
    if (responseCode == ErrorCode.SUCCESS) {
      resultAction?.call();
      return;
    }

    errorAction?.call();
  }
}

enum RequestMethod { get, post, put, patch, delete }
