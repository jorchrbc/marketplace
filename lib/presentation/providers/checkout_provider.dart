import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/cart_item.dart';
import 'package:marketplace/domain/repositories/order_repository.dart';
import 'package:marketplace/domain/entities/order_result.dart';

class CheckoutProvider extends ChangeNotifier {
  final OrderRepository orderRepository;
  String? _orderId;

  CheckoutProvider({required this.orderRepository});
  
  int _selectedPaymentMethod = 1; // 1: Mastercard, 2: Visa, 3: Efectivo
  bool _isLoading = false;

  String? get orderId => _orderId;
  int get selectedPaymentMethod => _selectedPaymentMethod;
  bool get isLoading => _isLoading;

  void changePaymentMethod(int method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  Future<bool> processPayment(String address, List<CartItem> cartItems) async {
    _isLoading = true;
    notifyListeners();

    String paymentMethodStr;
    switch (_selectedPaymentMethod) {
      case 1:
        paymentMethodStr = "MASTERCARD";
        break;
      case 2:
        paymentMethodStr = "VISA";
        break;
      case 3:
        paymentMethodStr = "EFECTIVO";
        break;
      case 4:
        paymentMethodStr = "PAYPAL";
        break;
      default:
        paymentMethodStr = "EFECTIVO";
    }

    final itemsInput = cartItems.map((item) {
      return {
        "product_id": int.tryParse(item.productId) ?? 0,
        "quantity": item.quantity
      };
    }).toList();

    try {
      final OrderResult orderResult = await orderRepository.createOrder(
          address, paymentMethodStr, itemsInput);
      final success = orderResult.success;
      _orderId = orderResult.orderId;

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      print("Checkout Error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
