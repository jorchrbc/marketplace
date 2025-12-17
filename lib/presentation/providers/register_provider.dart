import 'package:flutter/material.dart';

import 'package:marketplace/domain/entities/user.dart';

class RegisterProvider extends ChangeNotifier{

  String name = '';
  String phone = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User? user;

  bool validateUser(){
    return formKey.currentState?.validate() ?? false;
  }

void saveUser({required String name, required String phone, required String email, required String password}) {
  if(validateUser()){
    user = User(name: name, phone: phone, email: email, password: password);
    notifyListeners();
  }
}
}