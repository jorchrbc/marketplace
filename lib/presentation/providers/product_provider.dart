import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/product.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';


class ProductProvider extends ChangeNotifier {

  String name = '';
  String price = '';
  String? imagePath;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Product? product;

  AuthRepository authRepository;

  ProductProvider({required this.authRepository});

  bool validateProduct() {
    final form = formKey.currentState;
    if (form == null) return false;

    final isValid = form.validate();

    notifyListeners();
    return isValid;
  }

  void setImage(String path) {
    imagePath = path;
    notifyListeners();
  }

 void saveProduct() {
    product = Product(name: name, price: price, imagePath: imagePath);
  }

  Future<void> register(Product product) async{
    await authRepository.registerProduct(product);
  }
}