import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/domain/datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthDatasource datasource;
  AuthRepositoryImpl({required this.datasource});

  @override
  Future<void> registerUser(User user) {
    return datasource.registerUser(user);
  }

  @override
  Future<void> loginUser(String email, String password) {
    return datasource.loginUser(email, password);
  }
}