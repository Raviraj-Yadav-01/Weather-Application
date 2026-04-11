import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routers/app_routes_constant.dart';
import 'package:weather_app/feature/auth/controllers/auth_controller.dart';


class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var numberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  AuthController controller = Get.find<AuthController>();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 11.0, right: 11.0, top:100,bottom:11),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Create Account", style: TextStyle(color:Colors.white,fontSize: 34, fontWeight: FontWeight.bold)),
                SizedBox(height: 11),

                ///Name field
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your name";
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Enter your name...",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.white),
                    border:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(17)
                    )
                  ),
                ),
                SizedBox(height: 11),

                ///email
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
                          borderRadius:BorderRadius.circular(17)
                      )
                  ),
                ),
                SizedBox(height: 11),

                ///Mobile Number
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your mobile number";
                    }

                    if (value.length != 10) {
                      return "please enter your 10 digit mobile number";
                    }

                    return null;
                  },
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Enter your mobile number...",
                   hintStyle: TextStyle(color: Colors.white),
                    labelText: "mobile number",
                    labelStyle: TextStyle(color: Colors.white),
                      border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(17)
                      )
                  ),
                ),
                SizedBox(height: 11),

               //password
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
                              borderRadius:BorderRadius.circular(17)
                          )
                      ),
                    ),
                SizedBox(height: 11),

                ///confirm Password
                TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please retype your password";
                        } else if (passwordController.text != value) {
                          return "password doesn't match ";
                        } else {
                          return null;
                        }
                      },
                      controller: confirmPasswordController,

                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "retype your password here...",
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: "Confirm password",
                        labelStyle: TextStyle(color: Colors.white),
                          border:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(17)
                          )
                      ),
                    ),
                SizedBox(height: 11),

                //for error message
                Obx(() { return controller.signupError.value.isNotEmpty
                    ? Text(controller.signupError.value, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600))
                    : SizedBox();
                }),
                SizedBox(height: 8),

                ///Signup Button
                Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isSignupLoading.value
                        ? null
                        : () {
                      if (formkey.currentState!.validate()) {
                        controller.signupUser(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          mobNo: numberController.text.trim(),
                          password: passwordController.text.trim(),
                          onResult: (success) {
                            if (success) {
                              GoRouter.of(context).goNamed(MyAppConstants.loginRoute);
                            }
                          },
                        );
                      }
                    },
                    child: controller.isSignupLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Sign Up"),
                  ),
                )),

                SizedBox(height: 11),

                ///Text Button
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(MyAppConstants.loginRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("if already have an account,", style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 3),
                      Text(" login now...",
                        style: TextStyle(color: Color(0xffff3952), fontWeight: FontWeight.w600,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}