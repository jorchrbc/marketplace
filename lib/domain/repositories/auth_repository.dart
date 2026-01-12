import 'package:marketplace/domain/entities/entities.dart';


abstract class AuthRepository{
  Future<void> registerUser(User user);
  Future<void> registerProduct(Product product);
  Future<Map<String, dynamic>> loginUser(String email, String password);
  Future<void> logoutUser();
}
