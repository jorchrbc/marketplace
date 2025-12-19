import 'package:marketplace/domain/entities/entities.dart';

abstract class AuthDatasource{
  Future<void> registerUser(User user);
  Future<void> loginUser(String email, String password);
}