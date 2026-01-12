import 'dart:async';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/infrastructure/graphql/mutations.dart';

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

    Future<void> createProduct() async {
      // TODO: Implement code
    }
}
