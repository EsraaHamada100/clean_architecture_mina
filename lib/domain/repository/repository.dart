import 'package:clean_archeticture/data/network/failure.dart';
import 'package:clean_archeticture/data/network/requests.dart';
import 'package:clean_archeticture/domain/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  /// Either<Failure, Success> because the request may fail so we can't
  /// just write its type as Authentication
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
