import 'package:marketplace/domain/entities/user.dart';

abstract class AuthRepository{
  Future<void> registerUser(User user);
  Future<void> loginUser(String email, String password);
}