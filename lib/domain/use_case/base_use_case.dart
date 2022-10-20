import 'package:clean_archeticture/data/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<In, Out>{
  /// it is the base use case where the user will send the request
  /// with a dynamic input from presentation layer and it will be sent
  /// to data layer and get the response which is failure or dynamic response
  Future<Either<Failure,Out>> execute(In input);
}