import 'package:bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, params> {
  Future<Either<Failure, T>> execute([params params]);
}
