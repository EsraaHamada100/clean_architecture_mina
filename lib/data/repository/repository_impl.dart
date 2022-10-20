import 'package:clean_archeticture/data/data_source/remote_data_source.dart';
import 'package:clean_archeticture/data/mapper/mapper.dart';
import 'package:clean_archeticture/data/network/error_handler.dart';
import 'package:clean_archeticture/data/network/failure.dart';
import 'package:clean_archeticture/data/network/network_info.dart';
import 'package:clean_archeticture/data/network/requests.dart';
import 'package:clean_archeticture/domain/models/models.dart';
import 'package:clean_archeticture/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // the device is connected to internet
      try {
        final response = await _remoteDataSource.login(loginRequest);
        // this is the status inside the json response of API
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          return Right(response.toDomain());
        } else {
          // failure
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // no internet connection
      // return internet connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
