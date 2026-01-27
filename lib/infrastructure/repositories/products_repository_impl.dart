import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/entities/product.dart';
import 'package:marketplace/domain/entities/details.dart';
import 'package:marketplace/domain/entities/vendor_product.dart';

class ProductsRepositoryImpl extends ProductsRepository{
  final ProductsDatasource datasource;
  ProductsRepositoryImpl({required this.datasource});

  @override
  Future<void> createProduct(Product product) async {
    return datasource.createProduct(product);
  }
  
  @override
  Future<Details> productDetails(String id) async {
    return await datasource.productDetails(id);
  }

  @override
  Future<List<VendorProduct>> getMyProducts() async {
    return await datasource.getMyProducts();
  }
}
