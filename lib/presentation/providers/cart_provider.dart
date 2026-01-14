import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [
    // Datos de ejemplo iniciales (puedes quitarlos después)
    CartItem(
      id: '1', 
      name: 'Laptop', 
      price: 2000.00, 
      imageUrl: '', // Indicador para usar icono por defecto si está vacío
      quantity: 1
    ),
    CartItem(
      id: '2', 
      name: 'Diesel Bag', 
      price: 200.00, 
      imageUrl: '', 
      quantity: 1
    ),
  ];

  List<CartItem> get items => _items;

  double get subTotal {
    return _items.fold(0, (sum, item) => sum + item.total);
  }

  double get tax {
    // Ejemplo: Impuesto fijo o porcentaje. En el diseño era 60 envio? 
    // El diseño decía Envio $60.00. Asumiremos envio fijo por ahora.
    return 60.00; 
  }

  double get total {
    return subTotal + tax;
  }

  void addItem(CartItem item) {
    // Verificar si ya existe
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void incrementQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        // Opcional: remover si llega a 0
        // _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
