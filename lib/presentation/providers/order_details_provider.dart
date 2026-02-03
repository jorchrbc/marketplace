import 'package:flutter/material.dart';
import 'package:marketplace/domain/repositories/order_repository.dart';
import 'package:marketplace/domain/entities/order_details.dart';

class OrderDetailsProvider extends ChangeNotifier{
  String? address = null;
  String? status = null;
  String? payment_method = null;
  double? sub_total = null;
  double? tax = null;
  double? shipping = null;
  double? total = null;
  List<Map<String, dynamic>>? products = null;

  bool isLoading = false;
  String? errorMessage;
  
  OrderRepository orderRepository;

  OrderDetailsProvider({required this.orderRepository});

  Future<void> getOrderDetails(String id) async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try{
      OrderDetails orderDetails = await orderRepository.getOrderDetails(id);
      address = orderDetails.address;
      status = orderDetails.status;
      payment_method = orderDetails.payment_method;
      sub_total = orderDetails.sub_total;
      tax = orderDetails.tax;
      shipping = orderDetails.shipping;
      total = orderDetails.total;
      products = orderDetails.products;
    } catch(e){
      errorMessage = e.toString();
    } finally{
      isLoading = false;
      notifyListeners();
    }
  }
}
