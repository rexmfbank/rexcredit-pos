import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:rex_app/src/modules/api/exceptions/generic_api_exception.dart';
import 'package:rex_app/src/modules/api/exceptions/object_parse_exception.dart';
import 'package:rex_app/src/modules/api/exceptions/rex_api_exception.dart';

Either<RexApiException, E> transform<E>(
  dynamic data,
  E Function(dynamic) transformer,
) {
  try {
    return Right(transformer(data));
  } on RexApiException catch (e) {
    return Left(e);
  } on TypeError {
    if (data is Map) {
      final code = data['responseCode'];
      final msg = data['responseMessage'];
      if (code != null || msg != null) {
        return Left(
          RexApiException(
            message: msg?.toString() ?? 'Failed to parse server response',
            responseCode: code?.toString() ?? 'PARSE_ERR',
            responseMessage:
                msg?.toString() ?? 'Failed to parse server response',
          ),
        );
      }
    }
    return Left(ObjectParseException());
  } on Exception catch (e) {
    return Left(GenericApiException(e.toString()));
  }
}

Either<RexApiException, E> transformObject<E>(
  dynamic data,
  E Function(Object) transformer,
) {
  try {
    return Right(transformer(data));
  } on RexApiException catch (e) {
    return Left(e);
  } on TypeError {
    if (data is Map) {
      final code = data['responseCode'];
      final msg = data['responseMessage'];
      if (code != null || msg != null) {
        return Left(
          RexApiException(
            message: msg?.toString() ?? 'Failed to parse server response',
            responseCode: code?.toString() ?? 'PARSE_ERR',
            responseMessage:
                msg?.toString() ?? 'Failed to parse server response',
          ),
        );
      }
    }
    return Left(ObjectParseException());
  } on Exception catch (e) {
    return Left(GenericApiException(e.toString()));
  }
}

Either<RexApiException, E> processData<E>(
  E Function(dynamic) transformer,
  Either<RexApiException, Response?> response,
) {
  if (response.isLeft) return Left(response.left);

  final data = transform(response.right!.data, (p0) => transformer(p0));
  return data.either((left) => left, (right) => right);
}
