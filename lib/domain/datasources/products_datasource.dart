import 'package:marketplace/domain/entities/product.dart';
import 'package:marketplace/domain/entities/details.dart';

abstract class ProductsDatasource{
  Future<void> createProduct(Product product);
  Future<Details> productDetails(String id);
  Future<List> getProductsToBuy();
}
