

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
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

                SizedBox(
                  width:double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: Text("Sign Up"))),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
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