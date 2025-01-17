import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';


abstract interface class UsecaseWithParams<SucessType, Params> {
  Future<Either<Failure, SucessType>> call(Params params);
}

abstract interface class UsecaseWithoutParams<SucessType> {
  Future<Either<Failure, SucessType>> call();
}
