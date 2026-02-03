import 'package:flutter/material.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/entities/details.dart';

class HomeProvider extends ChangeNotifier{
  bool isLoading = false;
  String? errorMessage;

  AuthRepository authRepository;

  HomeProvider({
      required this.authRepository,
  });

  Future<void> logoutUser() async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try{
      await authRepository.logoutUser();
    } catch(e){
      errorMessage = e.toString();
    } finally{
      isLoading = false;
      notifyListeners();
    }
  }
}

