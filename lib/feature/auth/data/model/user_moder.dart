


import 'package:weather_app/core/constants/app_constants.dart';

class  UserModel{

  int? id;
  String name;
  String email;
  String mobNo;
  String? pass;


  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.mobNo,
    this.pass,
  });

  factory UserModel.fromMap(Map<String, dynamic>map ) => UserModel(
    id:map[AppConstants.userId],
    name:map[AppConstants.userName],
    email:map[AppConstants.userEmail],
    mobNo:map[AppConstants.userPassword],
   //pass:map[AppConstants.userPassword],
  );


  Map<String, dynamic> toMap() => {
    AppConstants.userName:name,
    AppConstants.userEmail:email,
    AppConstants.userMobileNumber:mobNo,
    AppConstants.userPassword:pass,
  };

}