import 'package:internet_connection_checker/internet_connection_checker.dart';
// this file is to check if there is a connection with internet or not
abstract class NetworkInfo{
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo{
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfoImpl(this._internetConnectionChecker);
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;

}