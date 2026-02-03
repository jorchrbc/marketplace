import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';

class RegisterProvider extends ChangeNotifier{

  String name = '';
  String? nameError;
  String lastName = '';
  String? lastNameError;
  String phone = '';
  String? phoneError;
  String? phoneErrorApi;
  String email = '';
  String? emailError;
  String? emailErrorApi;
  String password = '';
  String? passwordError;
  String? passwordErrorApi;
  String confirmPassword = '';
  String? confirmPasswordError;
  User? user;
  AuthRepository authRepository;

  RegisterProvider({required this.authRepository});

  void validateName(){
    if(name.isEmpty){
      nameError = 'Ingresar nombre';
    }else{
      nameError = null;
    }
    notifyListeners();
  }
  void validateLastName(){
    if(lastName.isEmpty){
      lastNameError = 'Ingresar apellidos';
    }else{
      lastNameError = null;
    }
    notifyListeners();
  }
  void validatePhone(){
    if(phone.isEmpty){
      phoneError = 'Ingresar teléfono';
    } else if(phoneErrorApi != null){
      phoneError = phoneErrorApi;
    } else{
      phoneError = null;
    }
    notifyListeners();
  }
  void validateEmail(){
    if(email.isEmpty){
      emailError = 'Ingresar email';
    } else if(emailErrorApi != null){
      emailError = emailErrorApi;
    } else{
      emailError = null;
    }
    notifyListeners();
  }
  void validatePassword(){
    if(password.isEmpty){
      passwordError = 'Ingresar contraseña';
    } else if(passwordErrorApi != null){
      passwordError = passwordErrorApi;
    }else{
      passwordError = null;
    }
    notifyListeners();
  }
  void validateConfirmPassword(){
    if(confirmPassword.isEmpty){
      confirmPasswordError = 'Confirmar contraseña';
    }else if(password != confirmPassword){
      confirmPasswordError = 'Las contraseñas no coinciden';
    }else{
      confirmPasswordError = null;
    }
    notifyListeners();
  }

  bool validateAllFields() {
    validateName();
    validateLastName();
    validatePhone();
    validateEmail();
    validatePassword();
    validateConfirmPassword();
    return [nameError, lastNameError, phoneError, emailError, passwordError,
    confirmPasswordError].every((error) => error == null);
  }

  Future<bool> validateUser() async {
    saveUser();
    var problems = await register();
    if(problems["connection"] != null){
      throw Exception(problems["connection"]);
    }
    if(problems["email"] != null){
      //emailErrorApi = problems["email"].toString();
      emailErrorApi = "Correo inválido";
    }else{emailErrorApi = null;}
    if(problems["number"] != null){
      //phoneErrorApi = problems["number"].toString();
      phoneErrorApi = "Teléfono inválido";
    }else{phoneErrorApi = null;}
    if(problems["password"] != null){
      //passwordErrorApi = problems["password"].toString();
      passwordErrorApi = "Contraseña inválida";
    }else{passwordErrorApi = null;}
    if(validateAllFields()){
      return true;
    }
    return false;
  }

  void saveUser() {
    user = User(name: name, lastName: lastName, phone: phone, email: email, password: password);
  }

  void cleanAll(){
    name = '';
    nameError = null;
    lastName = '';
    lastNameError = null;
    phone = '';
    phoneError = null;
    phoneErrorApi = null;
    email = '';
    emailError = null;
    emailErrorApi = null;
    password = '';
    passwordError = null;
    passwordErrorApi = null;
    confirmPassword = '';
    confirmPasswordError = null;
    user = null;
  }

  Future<Map<String, dynamic>> register() async{
    return await authRepository.registerUser(user!);
  }
}
