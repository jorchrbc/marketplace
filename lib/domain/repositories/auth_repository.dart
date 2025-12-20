import 'package:marketplace/domain/entities/user.dart';

abstract class AuthRepository{
  Future<void> registerUser(User user);
  Future<Map<String, dynamic>> loginUser(String email, String password);
  Future<void> logoutUser();
}