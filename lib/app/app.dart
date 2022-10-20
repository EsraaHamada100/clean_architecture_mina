
import 'package:clean_archeticture/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // I will make MyApp class a singleton class

  // named private constructor of MyApp
  // some people write it like that MyApp._() it doesn't matter
  MyApp._internal();
  // I made an instance of the class that I can use
  // so if you write MyApp.instance it will always refere to the same
  // and only instance
  static final MyApp instance = MyApp._internal();

  // without the below line when the user write MyApp() it will give him an
  // error so you should use that to let the user use the default method
  // without any errors and that will return also the only instance available

  // so you can access the instance with two methods
  // var myApp = MyApp.instance;
  // var myApp = MyApp();

  // some people like to extend it even farther and make the instance private
  // so you can only access the one and only instance of this class by writing
  // var myApp = MyApp();

  factory MyApp()=>instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
