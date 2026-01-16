import 'package:marketplace/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Cart?> getMyCart();
  Future<Cart?> addToCart(String productId, int quantity);
  Future<Cart?> removeFromCart(String cartItemId);
  Future<Cart?> updateCartItem(String cartItemId, int quantity);
}
