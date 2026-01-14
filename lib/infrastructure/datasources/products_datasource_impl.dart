import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/infrastructure/graphql/products_mutations.dart';
import 'package:marketplace/domain/entities/product.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  late final GraphQLClient client;

  ProductsDatasourceImpl(){
    final httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql');
    // final authLink = AuthLink(getToken: null);

    client = GraphQLClient(
      // link: authLink.concat(httpLink),
      link: httpLink,
      cache: GraphQLCache(),
    );
  }
  
  
    
  @override
  Future<void> createProduct(Product product) async {
    print("Iniciando mutacion");
    final MutationOptions options = MutationOptions(
      document: gql(createNewProduct),
      variables: {
        'name': product.name,
        'price': product.price,
        'image': product.imageFile != null
          ? await http.MultipartFile.fromBytes(
            'image',
            await product.imageFile!.readAsBytes(),
            filename: product.imageFile!.path.split('/').last,
            )
          : null,
      }
    );
    print("Intento de mutacion hecho");
    final result = await client.mutate(options);
    if (result.hasException) {
      final error = result.exception!.graphqlErrors.first;
      print("----------------------------------------------------\n");
      print('Error: ${error.message}');
      print("----------------------------------------------------\n");
      if(error.extensions != null) print('Validation: ${error.extensions!["validation"]}');
      throw Exception('Validation: ${error.extensions!["validation"]}');
    }
    print('Producto creado: ${result.data?["createProduct"]}');
  }
}
