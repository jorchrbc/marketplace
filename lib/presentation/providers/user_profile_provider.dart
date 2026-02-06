import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';

class UserProfileProvider extends ChangeNotifier{
  String name = '';
  String lastName = '';
  String phone = '';
  String email = '';

  bool isLoading = false;
  String? errorMessage;

  AuthRepository authRepository;

  UserProfileProvider({required this.authRepository});

  void clearAll(){
   name = '';
   lastName = '';
   phone = '';
   email = '';
    notifyListeners();
  }

 Future<void> getUserInfo() async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try{
      User user = await authRepository.viewProfile();
      name = user.name;
      lastName = user.lastName;
      phone = user.phone;
      email = user.email;
   
    }catch(e){
      errorMessage = e.toString();
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  
  
}