import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';

class LoginProvider extends ChangeNotifier{
  String email = '';
  String password = '';

  AuthRepository authRepository;

  LoginProvider({required this.authRepository});

  Future<void> login(User user) async{
    await authRepository.loginUser(email, password);
  }
}