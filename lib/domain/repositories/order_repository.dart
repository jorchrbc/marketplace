import 'package:marketplace/domain/entities/order_details.dart';

abstract class OrderRepository {
  Future<bool> createOrder(String address, String paymentMethod, List<Map<String, dynamic>> items);
  Future<OrderDetails> getOrderDetails(String id);
}
