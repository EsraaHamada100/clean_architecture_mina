import 'package:clean_archeticture/app/dependency_injection.dart';
import 'package:clean_archeticture/presentation/forgot_password/forgot_password_view.dart';
import 'package:clean_archeticture/presentation/login/view/login_view.dart';
import 'package:clean_archeticture/presentation/main/main_view.dart';
import 'package:clean_archeticture/presentation/onboarding/view/onboarding_view.dart';
import 'package:clean_archeticture/presentation/register/register_view.dart';
import 'package:clean_archeticture/presentation/resources/strings_manager.dart';
import 'package:clean_archeticture/presentation/splash/splash_view.dart';
import 'package:clean_archeticture/presentation/store_details/store_details_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute :
        return MaterialPageRoute(builder: (_)=> const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound),),
      ),
    );
  }
}
