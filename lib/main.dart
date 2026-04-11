import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/routers/app_routes_configuration.dart';
import 'package:weather_app/feature/auth/controllers/auth_controller.dart';

void main() {
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: MyRoutesApp().router,
    );
  }
}