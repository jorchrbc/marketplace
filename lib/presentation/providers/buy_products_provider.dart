import 'package:flutter/material.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/entities/details.dart';

class BuyProductsProvider extends ChangeNotifier {
  List productsToBuy = [];

  bool isInitialLoading = false;
  bool isFetchingMore = false;

  String? errorMessage;
  int currentPage = 1;
  bool hasMore = true;

  final ProductsRepository productsRepository;

  BuyProductsProvider({required this.productsRepository});

  Future<void> getProductsToBuy({bool nextPage = false}) async {
    if (!hasMore && nextPage) return;
    if (isFetchingMore && nextPage) return;

    errorMessage = null;

    if (nextPage) {
      isFetchingMore = true;
    } else {
      isInitialLoading = true;
      currentPage = 1;
      hasMore = true;
    }

    notifyListeners();

    try {
      final pageToFetch = nextPage ? currentPage + 1 : 1;
      final newProducts =
          await productsRepository.getProductsToBuy(page: pageToFetch);

      if (nextPage) {
        productsToBuy.addAll(newProducts);
        currentPage++;
      } else {
        productsToBuy = newProducts;
      }

      if (newProducts.isEmpty) hasMore = false;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isInitialLoading = false;
      isFetchingMore = false;
      notifyListeners();
    }
  }
}

