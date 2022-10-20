import 'package:clean_archeticture/app/app_prefs.dart';
import 'package:clean_archeticture/data/data_source/remote_data_source.dart';
import 'package:clean_archeticture/data/network/app_api.dart';
import 'package:clean_archeticture/data/network/dio_factory.dart';
import 'package:clean_archeticture/data/network/network_info.dart';
import 'package:clean_archeticture/data/repository/repository_impl.dart';
import 'package:clean_archeticture/domain/repository/repository.dart';
import 'package:clean_archeticture/domain/use_case/login_use_case.dart';
import 'package:clean_archeticture/presentation/login/view/login_view.dart';
import 'package:clean_archeticture/presentation/login/view_model/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

/// here we will get instances of all app classes that we will use
/// and put them in the GetIt so we can access them later easily
Future<void> initAppModule() async {
  // app module , it's a module where we put all generic dependencies injection
  final sharedPrefs = await SharedPreferences.getInstance();

  /// here we put it in GetIt instance so we can access it easily
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  /// here we initialize an instance of AppPreferences and put it in GetIt
  /// note that when we write instance() inside AppPreferences the GetIt will
  /// give AppPreferences an instance of SharedPreferences as it knows that implicitly
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  /// we can also write something like that
  // instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance<AppPreferences>()));
  /// or we can even make it more detailed like that but there is no need for that
  // AppPreferences appPreferences = AppPreferences(instance<SharedPreferences>());
  // instance.registerLazySingleton<AppPreferences>(() => appPreferences);

  // network info
  /// we write NetworkInfoImpl inside because NetworkInfo is an abstract class
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(instance<AppPreferences>()));

  // app service client
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));
}

initLoginModule() {
  // login module , it's a module where we put all login dependencies injection

  /// we used register factory not lazy singleton because we don't want the programm
  /// to keep the values in all the time it's running

  /// we checked here if the value is already in the GetIt or not to make
  /// sure that he is not register the value again
  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory(() => LoginUseCase(instance<Repository>()));
    instance.registerFactory(() => LoginViewModel(instance<LoginUseCase>()));
  }

}
