import 'package:flutter/material.dart';

import 'package:marketplace/domain/entities/user.dart';

class RegisterProvider extends ChangeNotifier{

  String name = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String role = '';
  String? roleError;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User? user;

  void setRole(String value){
    role = value;
    roleError = null;
    notifyListeners();
  }

  bool validateUser() {
    final form = formKey.currentState;
    if (form == null) return false;

    bool isValid = form.validate();
    bool isRoleSelected = true;

    if(role == ''){
      roleError = 'Seleccionar rol';
      isRoleSelected = false;
    } else {
      roleError = null;
    }
    notifyListeners();
    return isValid && isRoleSelected;
  }

  void saveUser() {
    user = User(name: name, lastName: lastName, phone: phone, email: email, password: password, role: role);
    notifyListeners();
  }
}