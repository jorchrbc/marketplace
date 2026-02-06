import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/domain/datasources/auth_datasource.dart';
import 'package:marketplace/domain/services/token_storage.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthDatasource datasource;
  final TokenStorage tokenStorage;
  AuthRepositoryImpl({required this.datasource, required this.tokenStorage});

  @override
  Future<Map<String,dynamic>> registerUser(User user) {
    return datasource.registerUser(user);
  }

  @override
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final data = await datasource.loginUser(email, password);
    await tokenStorage.saveToken(
      "${data['token_type']} ${data['access_token']}"
    );
    return data;
  }

  @override
  Future<User> viewProfile() async{
    return await datasource.viewUser();
  
  }

  @override
  Future<void> logoutUser() async{
    try{
      await datasource.logoutUser();
    } finally {
      await tokenStorage.deleteToken();
    }
      
  }
}
