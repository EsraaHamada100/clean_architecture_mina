import 'dart:async';

import 'package:clean_archeticture/presentation/base/base_view_model.dart';

import '../../../domain/use_case/login_use_case.dart';
import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  // TODO: implement inputAreAllInputsValid
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    // we make that to make the stream work every time the user
    // change user name data we aren't interested in any value so we but null
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    // we make that to make the stream work every time the user
    // change user name data we aren't interested in any value so we but null
    inputAreAllInputsValid.add(null);
  }

  @override
  login() async {
    /// fold is a function in Either class to handle left and right
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  // left -> failure
                  print(failure.message)
                },
            (data) => {
                  // right => success
                  print(data.customer?.name)
                });
  }

  // outputs
  @override
  // TODO: implement outIsPasswordValid
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outIsUserNameValid
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  // TODO: implement outAreAllInputsValid
  // we add _ because we not trigger any events we just use another streams
  // to get the output of this stream
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());
  bool _isPasswordValid(String password) {
    print('password valid $password');
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    print('userName valid $userName');
    return userName.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;
}
