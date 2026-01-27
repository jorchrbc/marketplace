import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/vendor_product.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';

class VendorProductsProvider extends ChangeNotifier {
  
  final ProductsRepository productsRepository;

  VendorProductsProvider({required this.productsRepository});

  List<VendorProduct> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<VendorProduct> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await productsRepository.getMyProducts();
    } catch (e) {
      _errorMessage = e.toString();
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
