import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/entities/product.dart';
import 'package:marketplace/domain/entities/details.dart';

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
}
