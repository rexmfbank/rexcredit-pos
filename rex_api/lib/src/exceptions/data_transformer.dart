import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:rex_api/src/exceptions/ground_exception.dart';
import 'package:rex_api/src/exceptions/object_parse_exception.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';

Either<RexApiException, E> transform<E>(
    dynamic data, E Function(dynamic) transformer) {
  try {
    return Right(transformer(data));
  } on RexApiException catch (e) {
    return Left(e);
  } on TypeError {
    return Left(ObjectParseException());
  } on Exception catch (e) {
    return Left(GroundException(e.toString()));
  }
}

Either<RexApiException, E> transformObject<E>(
    dynamic data, E Function(Object) transformer) {
  try {
    return Right(transformer(data));
  } on RexApiException catch (e) {
    return Left(e);
  } on TypeError {
    return Left(ObjectParseException());
  } on Exception catch (e) {
    return Left(GroundException(e.toString()));
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
