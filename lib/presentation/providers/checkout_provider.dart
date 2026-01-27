import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {

  int _selectedPaymentMethod = 1; // 1: Mastercard, 2: Visa, 3: Efectivo
  bool _isLoading = false;

  int get selectedPaymentMethod => _selectedPaymentMethod;
  bool get isLoading => _isLoading;

  void changePaymentMethod(int method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  Future<bool> processPayment() async {
    _isLoading = true;
    notifyListeners();

    // Simular delay del backend
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    
    return true; // Retornar true si fue exitoso
  }
}