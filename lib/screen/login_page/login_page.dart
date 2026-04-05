

import 'package:flutter/material.dart';
import 'package:weather_app/app_routes/app_routes.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key:formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[

              TextFormField(
                onChanged: (value) {},
                validator: (value) {
                  final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value ?? "");

                  if (value == null || value.isEmpty) {
                    return "please enter your email";
                  } else if (!emailValid) {
                    return "please enter valid email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Enter your email...",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "email",
                  labelStyle: TextStyle(color: Colors.white),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17)
                  )
                ),
              ),
              SizedBox(height: 11),

              TextFormField(
                validator: (value) {
                  final bool passwordValid = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                  ).hasMatch(value ?? "");

                  if (value == null || value.isEmpty) {
                    return "please enter your password";
                  } else if (!passwordValid) {
                    return "please enter a valid password";
                  } else {
                    return null;
                  }
                },

                controller: passwordController,
                style: TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Enter your password here...",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17)
                    )
                ),
              ),
              SizedBox(
                height:11
              ),

              SizedBox(
                width:double.infinity,
                  child: ElevatedButton(onPressed: (){},child:Text("Log In"))),
              SizedBox(height:11),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.signup);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("if not registered", style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 3),
                    Text("Create now", style: TextStyle(color: Color(0xffff3952), fontWeight: FontWeight.w600,),),
                  ],
                ),
              ),

            ]
          ),
        ),
      )
    );
  }
}