import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/cart.dart';
import 'package:marketplace/domain/entities/cart_item.dart';
import 'package:marketplace/domain/repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository cartRepository;

  CartProvider({required this.cartRepository});

  List<CartItem> _items = [];
  double _subTotal = 0.0;
  double _tax = 0.0;
  double _shipping = 60.0; 
  double _total = 0.0;
  
  bool _isLoading = false;

  List<CartItem> get items => _items;
  double get subTotal => _subTotal;
  double get tax => _tax;
  double get shipping => _shipping;
  double get total => _total;
  bool get isLoading => _isLoading;

  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final cart = await cartRepository.getMyCart();
      _updateCartData(cart);
    } catch (e) {
      print("Error loading cart: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(String productId, int quantity) async {
      _isLoading = true;
      notifyListeners();

      try {
        final cart = await cartRepository.addToCart(productId, quantity);
        _updateCartData(cart);
      } catch (e) {
        print("Error adding item: $e");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
  }

  Future<void> incrementQuantity(String cartItemId, int currentQuantity) async {
    await _updateCartItem(cartItemId, currentQuantity + 1);
  }

  Future<void> decrementQuantity(String cartItemId, int currentQuantity) async {
    if (currentQuantity > 1) {
       await _updateCartItem(cartItemId, currentQuantity - 1);
    }
  }

  Future<void> _updateCartItem(String cartItemId, int quantity) async {
    _isLoading = true;
    notifyListeners();
    try {
      final cart = await cartRepository.updateCartItem(cartItemId, quantity);
       _updateCartData(cart);
    } catch (e) {
      print('Error updating item: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> removeItem(String cartItemId) async {
      _isLoading = true;
      notifyListeners();
      try {
        final cart = await cartRepository.removeFromCart(cartItemId);
        _updateCartData(cart);
      } catch (e) {
        print("Error removing item: $e");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
  }

  void _updateCartData(Cart? cart) {
    if (cart != null) {
      _items = cart.items;
      _subTotal = cart.subtotal;
      _tax = cart.taxes;
      _shipping = cart.shipping;
      _total = cart.total;
    }
  }
}
