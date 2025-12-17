import 'package:flutter/material.dart';

import 'package:marketplace/domain/entities/user.dart';

class RegisterProvider extends ChangeNotifier{

  String name = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User? user;

  bool validateUser() {
    final form = formKey.currentState;
    if (form == null) return false;
    if (!form.validate()) return false;
    return true;
  }

  void saveUser() {
    user = User(name: name, lastName: lastName, phone: phone, email: email, password: password);
    notifyListeners();
  }
}