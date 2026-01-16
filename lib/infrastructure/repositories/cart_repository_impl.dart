import 'package:marketplace/domain/datasources/cart_datasource.dart';
import 'package:marketplace/domain/entities/cart.dart';
import 'package:marketplace/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatasource datasource;

  CartRepositoryImpl({required this.datasource});

  @override
  Future<Cart?> getMyCart() {
    return datasource.getMyCart();
  }

  @override
  Future<Cart?> addToCart(String productId, int quantity) {
    return datasource.addToCart(productId, quantity);
  }
}
