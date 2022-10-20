import 'package:clean_archeticture/data/network/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // error from  API or from Dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioErrorType.response:
      // it means that error is from API while other type of errors
      // are from dio itself
      if (error.response != null &&
          error.response!.statusCode != null &&
          error.response!.statusMessage != null) {
        // I am sure that it will not be null but I have to do that
        // because the editor give me an error
        return Failure(error.response!.statusCode ?? 0,
            error.response!.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
    // default :
    //   return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNET_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data
  static const int BAD_REQUEST = 400; // failure API rejected request
  static const int UNAUTHORIZED = 401; // failure user is not authorized
  static const int FORBIDDEN = 403; // failure API rejected request
  static const int NOT_FOUND = 404; // not found
  static const int INTERNET_SERVER_ERROR = 500; // crash in server side

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "Success"; // success with data
  static const String NO_CONTENT = "Success"; // success with no data
  static const String BAD_REQUEST =
      "Bad request, Try again later"; // failure API rejected request
  static const String UNAUTHORIZED =
      "User is unauthorized , Try again later"; // failure user is not authorized
  static const String FORBIDDEN =
      "Forbidden request , Try again later"; // failure API rejected request
  static const String NOT_FOUND = "Something went wrong , Try again later";
  static const String INTERNET_SERVER_ERROR =
      "Something went wrong , Try again later"; // crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = "Timeout error , Try again later";
  static const String CANCEL = "Request was canceled , Try again later";
  static const String RECEIVE_TIMEOUT = "Timeout error , Try again later";
  static const String SEND_TIMEOUT = "Timeout error , Try again later";
  static const String CACHE_ERROR = "Cache error , Try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
  static const String DEFAULT = "Something went wrong , Try again later";
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);

        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNET_SERVER_ERROR:
        return Failure(ResponseCode.INTERNET_SERVER_ERROR,
            ResponseMessage.INTERNET_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}


class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
