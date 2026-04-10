import 'package:flutter/material.dart';
import 'package:weather_app/core/routers/app_routes_configuration.dart';


void main() {
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

