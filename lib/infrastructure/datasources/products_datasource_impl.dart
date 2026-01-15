import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/infrastructure/graphql/products_mutations.dart';
import 'package:marketplace/domain/entities/product.dart';
import 'package:marketplace/domain/services/token_storage.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  late final GraphQLClient client;
  final TokenStorage tokenStorage;

  ProductsDatasourceImpl({required this.tokenStorage}){
    final httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql');
    final authLink = AuthLink(
      getToken: () async{
        final token = await tokenStorage.getToken();
        return token;
      },
    );

    client = GraphQLClient(
      link: authLink.concat(httpLink),
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
    final result = await client.mutate(options);
    if (result.hasException) {
      final exception = result.exception!;
      if(exception.linkException != null){
        print('Network error: ${exception.linkException}');
        throw Exception("La conexión es inestable.");
      }
      if(exception.graphqlErrors.isNotEmpty){
        final error = exception.graphqlErrors.first;
        throw Exception(error.message);
      }
    }
    print('Producto creado: ${result.data?["createProduct"]}');
  }
}
