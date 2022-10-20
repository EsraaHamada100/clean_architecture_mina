import 'package:clean_archeticture/app/app.dart';
import 'package:clean_archeticture/app/dependency_injection.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  // You can also write MyApp()
  runApp(MyApp.instance);
}
