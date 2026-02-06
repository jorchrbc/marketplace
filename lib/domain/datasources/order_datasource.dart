import 'package:marketplace/domain/entities/order_details.dart';
import 'package:marketplace/domain/entities/order_result.dart';
abstract class OrderDatasource {
  Future<OrderResult> createOrder(String address, String paymentMethod, List<Map<String, dynamic>> items);
  Future<OrderDetails> getOrderDetails(String id);
}
