import 'package:marketplace/domain/entities/cart.dart';

abstract class CartDatasource {
  Future<Cart?> getMyCart();
  Future<Cart?> addToCart(String productId, int quantity);
}
