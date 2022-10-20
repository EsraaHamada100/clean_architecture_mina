import 'package:clean_archeticture/app/constants.dart';
import 'package:clean_archeticture/data/response/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

/// we use retrofit to help us in reducing api code we write
/// to do that you should write that command line in terminal
/// don't forget to add [part fileName.g.dart]
/// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  // run flutter pub get && flutter pub run build_runner build
  // --delete-conflicting-outputs now
  @POST("customer/login")
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );
  // run flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
}
