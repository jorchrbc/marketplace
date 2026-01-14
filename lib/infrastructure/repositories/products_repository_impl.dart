import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/entities/product.dart';

class ProductsRepositoryImpl extends ProductsRepository{
  final ProductsDatasource datasource;
  ProductsRepositoryImpl({required this.datasource});

  @override
  Future<void> createProduct(Product product) async {
    return datasource.createProduct(product);
  }
}
