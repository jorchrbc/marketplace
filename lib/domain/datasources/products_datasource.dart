import 'package:marketplace/domain/entities/product.dart';
import 'package:marketplace/domain/entities/details.dart';
import 'package:marketplace/domain/entities/vendor_product.dart';

abstract class ProductsDatasource{
  Future<void> createProduct(Product product);
  Future<Details> productDetails(String id);
  Future<List<VendorProduct>> getMyProducts();
  Future<void> deleteProduct(String id);
  Future<List> getProductsToBuy({int page});
}
