import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/datasources/products_datasource.dart';

class ProductsRepositoryImpl extends ProductsRepository{
  final ProductsDatasource datasource;
  ProductsRepositoryImpl({required this.datasource});

  @override
  Future<void> createProduct() async {
    // TODO: Implement
  }
}
