import 'package:flutter/material.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/entities/details.dart';

class BuyProductsProvider extends ChangeNotifier{
  List productsToBuy = [];
  bool isLoading = false;
  String? errorMessage;

  ProductsRepository productsRepository;

  BuyProductsProvider({
      required this.productsRepository,
  });
  
  Future<void> getProductsToBuy() async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try{
      productsToBuy = await productsRepository.getProductsToBuy();
      notifyListeners();
    } catch(e){
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
