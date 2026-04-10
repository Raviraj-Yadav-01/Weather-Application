
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routers/app_routes_constant.dart';

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
      GoRouter.of(context).goNamed(MyAppConstants.loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            SizedBox(
              height:100,
                width:100,
                child: FlutterLogo()),
            SizedBox(height:11),

            Text("Weather",style:TextStyle(fontSize:30, fontWeight:FontWeight.w700)),

          ]
        ),
      )
    );
  }
}