
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routers/app_routes_constant.dart';
import 'package:weather_app/feature/auth/presentation/login_page/login_page.dart';
import 'package:weather_app/feature/auth/presentation/signup_page/signup_page.dart';
import 'package:weather_app/feature/auth/presentation/splash_page/splash_page.dart';
import 'package:weather_app/feature/weather/presentation/home_page/home_page.dart';

class MyRoutesApp{

  GoRouter router = GoRouter(

    initialLocation: '/',

      routes: [

        GoRoute(
          name: MyAppConstants.splashRoute,
          path: '/',
          pageBuilder:(context, state) => MaterialPage(child: SplashPage())
        ),

        GoRoute(
          name: MyAppConstants.loginRoute,
          path: '/profile',
          pageBuilder:(context, state) => MaterialPage(child: LoginPage())
        ),

        GoRoute(
          name: MyAppConstants.signupRoute,
          path: '/contact',
          pageBuilder:(context, state) => MaterialPage(child: SignUpPage())
        ),

        GoRoute(
          name: MyAppConstants.homeRoute,
          path: '/about',
          pageBuilder:(context, state) => MaterialPage(child: HomePage())
        ),

      ],
  );
}