import 'package:marketplace/domain/entities/product.dart';

abstract class ProductsRepository{
  Future<void> createProduct(Product product);
}
