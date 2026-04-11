import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routers/app_routes_constant.dart';
import 'package:weather_app/feature/auth/controllers/auth_controller.dart';



class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthController controller = Get.find<AuthController>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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

              ////Email field
              TextFormField(
                onChanged: (value) {},
                validator: (value) {
                  final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",).hasMatch(value ?? "");

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
                style: TextStyle(color: Colors.white),
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
                  final bool passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',).hasMatch(value ?? "");

                  if (value == null || value.isEmpty) {
                    return "please enter your password";
                  } else if (!passwordValid) {
                    return "please enter a valid password";
                  } else {
                    return null;
                  }
                },

                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter your password here...",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(17))
                ),
              ),
              SizedBox(height:11),

              //Login Button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoginLoading.value ? null : () {
                    if (formkey.currentState!.validate()) {
                      controller.loginUser(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        onResult: (success) {
                          if (success) {
                            GoRouter.of(context).goNamed(MyAppConstants.homeRoute);
                          }
                        },
                      );
                    }
                  },
                  child: controller.isLoginLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Log In"),
                ),
              )),
              SizedBox(height:11),


              ///Text Button
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(MyAppConstants.signupRoute);
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