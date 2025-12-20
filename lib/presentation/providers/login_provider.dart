import 'package:flutter/material.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';

class LoginProvider extends ChangeNotifier {
  String email = '';
  String password = '';
  bool isLoading = false;
  String? errorMessage;

  final AuthRepository authRepository;

  LoginProvider({required this.authRepository});

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<bool> login() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await authRepository.loginUser(email, password);
      // TODO: Save token and user info
      print('Login success: $result');
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}