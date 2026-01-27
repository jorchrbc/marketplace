import 'package:marketplace/domain/datasources/order_datasource.dart';
import 'package:marketplace/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDatasource datasource;

  OrderRepositoryImpl({required this.datasource});

  @override
  Future<bool> createOrder(String address, String paymentMethod, List<Map<String, dynamic>> items) {
    return datasource.createOrder(address, paymentMethod, items);
  }
}
