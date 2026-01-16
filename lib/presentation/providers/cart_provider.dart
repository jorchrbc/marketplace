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

  Future<void> _modifyItem(String productId, int quantity) async {
      _isLoading = true;
      notifyListeners();

      try {
        final cart = await cartRepository.addToCart(productId, quantity);
        _updateCartData(cart);
      } catch (e) {
        print("Error modifying item: $e");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
  }

  Future<void> addItem(String productId, int quantity) async {
    await _modifyItem(productId, quantity);
  }

  Future<void> incrementQuantity(String productId, int currentQuantity) async {
    // Asumimos que el backend es aditivo (suma la cantidad enviada)
    await addItem(productId, 1);
  }

  Future<void> decrementQuantity(String productId, int currentQuantity) async {
    if (currentQuantity > 1) {
       // Enviamos -1 para restar 1
       await addItem(productId, -1);
    } else {
       // Opcional: Manejar eliminación si llega a 0
    }
  }

  Future<void> removeItem(String itemId) async {
      final index = _items.indexWhere((item) => item.id == itemId);
      if(index == -1) return;
      
      final productId = _items[index].productId;
      final currentQuantity = _items[index].quantity;
      
      // Restamos toda la cantidad actual para eliminarlo
      await addItem(productId, -currentQuantity);
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
