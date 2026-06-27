import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'data_transformer.dart';
import 'error_code.dart';
import '../exceptions/generic_api_exception.dart';
import '../exceptions/response_exceptions.dart';
import '../exceptions/rex_api_exception.dart';
import 'interceptors.dart';
import 'package:either_dart/either.dart';

class AppNetworkProvider {
  Dio getDioInstance() {
    var dio = Dio(
      BaseOptions(
        connectTimeout: Duration(milliseconds: 50000),
        receiveTimeout: Duration(milliseconds: 50000),
      ),
    );
    dio.interceptors.add(EncryptionInterceptor());
    dio.interceptors.addAll([AppInterceptor(), ConnectivityInterceptor()]);
    dio.interceptors.add(
      PrettyDioLogger(
        responseBody: returnBoolForLogs(),
        error: returnBoolForLogs(),
        request: returnBoolForLogs(),
        requestBody: returnBoolForLogs(),
        requestHeader: returnBoolForLogs(),
        responseHeader: returnBoolForLogs(),
      ),
    );
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
    } on DioException catch (e, _) {
      final error = transformObject(e, ((p0) => ResponseException.fromDio(p0)));
      if (error.isLeft) return Left(error.left);
      return Left(error.right);
    } on Exception catch (e, _) {
      return Left(GenericApiException(e.toString()));
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
    } on DioException catch (e, _) {
      final error = transformObject(e, ((p0) => ResponseException.fromDio(p0)));
      if (error.isLeft) return Left(error.left);
      return Left(error.right);
    } on Exception catch (e, _) {
      return Left(GenericApiException(e.toString()));
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
