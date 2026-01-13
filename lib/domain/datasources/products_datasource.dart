import 'package:marketplace/domain/entities/product.dart';

abstract class ProductsDatasource{
  Future<void> createProduct(Product product);
}
