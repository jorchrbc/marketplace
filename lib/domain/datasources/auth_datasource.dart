import 'package:marketplace/domain/entities/entities.dart';

abstract class AuthDatasource{
  Future<Map<String,dynamic>> registerUser(User user);
  Future<Map<String, dynamic>> loginUser(String email, String password);
  Future<void> logoutUser();
  Future<void> registerProduct(Product product);
}
