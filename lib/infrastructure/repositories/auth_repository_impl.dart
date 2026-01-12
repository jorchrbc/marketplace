import 'package:marketplace/domain/entities/entities.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthDatasource datasource;
  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Map<String,dynamic>> registerUser(User user) {
    return datasource.registerUser(user);
  }

  @override
  Future<Map<String, dynamic>> loginUser(String email, String password) {
    return datasource.loginUser(email, password);
  }

  @override
  Future<void> logoutUser() {
    return datasource.logoutUser();
  }
  
  @override
  Future<void> registerProduct(Product product) {
    return datasource.registerProduct(product);
  }
  
}
