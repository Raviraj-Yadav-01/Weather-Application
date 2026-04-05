
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/app_routes/app_routes.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

   @override
  void initState() {
    super.initState();

    Timer(Duration(seconds:3),(){
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children:[
          FlutterLogo(),
          SizedBox(height:11),

          Text("Weather",style:TextStyle(fontSize:14, fontWeight:FontWeight.w600)),

        ]
      )
    );
  }
}