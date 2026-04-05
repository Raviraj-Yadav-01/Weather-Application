
import 'package:flutter/material.dart';
import 'package:weather_app/screen/dashboard/dashboard_nav_pages/home_page.dart';
import 'package:weather_app/screen/login_page/login_page.dart';
import 'package:weather_app/screen/signup_page/signup_page.dart';
import 'package:weather_app/screen/splash_page/splash_page.dart';

class AppRoutes {


  static const String splash = "/splash";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String homepage = "/home";


  static  Map<String, WidgetBuilder > mRoutes = {
    splash : (context) => SplashPage(),
    login : (context) => LoginPage(),
    signup : (context) => SignUpPage(),
    homepage : (context) => HomePage(),




  };


}