

import 'package:freezed_annotation/freezed_annotation.dart';
/// we use freezed to help us in reducing the code we write
/// to do that you should write that command line in terminal
/// /// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
/// don't forget to add [part fileName.freezed.dart]

part 'freezed_data_classes.freezed.dart';
@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String userName, String password) = _LoginObject;
}