import 'dart:async';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/infrastructure/graphql/products_mutations.dart';
import 'package:marketplace/domain/entities/product.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  final HttpLink httpLink;
  late final GraphQLClient client;

  ProductsDatasourceImpl()
    : httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql') {
      client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
    }
    
  @override
  Future<void> createProduct(Product product) async {
    final MutationOptions options = MutationOptions(
      document: gql(createNewProduct),
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }
}
