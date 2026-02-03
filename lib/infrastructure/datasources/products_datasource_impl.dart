import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/core/constants.dart';
import 'package:marketplace/domain/datasources/products_datasource.dart';
import 'package:marketplace/infrastructure/graphql/products_mutations.dart';
import 'package:marketplace/domain/entities/product.dart';
import 'package:marketplace/domain/entities/details.dart';
import 'package:marketplace/domain/entities/vendor_product.dart';
import 'package:marketplace/domain/services/token_storage.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  late final GraphQLClient client;
  final TokenStorage tokenStorage;

  ProductsDatasourceImpl({required this.tokenStorage}){
    final httpLink = HttpLink(endpoint);
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
    final MutationOptions options = MutationOptions(
      document: gql(createNewProduct),
      variables: {
        'name': product.name,
        'price': product.price,
        'stock':product.stock,
        'description':product.dscrp,
        'image': product.imageFile != null
          ? await http.MultipartFile.fromBytes(
            'image',
            await product.imageFile!.readAsBytes(),
            filename: product.imageFile!.path.split('/').last,
          )
          : null,
      }
    );
    try {
      final result = await client.mutate(options).timeout(const Duration(seconds: 60));
      
      if (result.hasException) {
        final exception = result.exception!;
        if(exception.linkException != null){
          throw Exception("La conexión es inestable.");
        }
        if(exception.graphqlErrors.isNotEmpty){
          final error = exception.graphqlErrors.first;
          throw Exception(error.message);
        }
      }
    } on TimeoutException {
       throw Exception("La petición tardó demasiado en responder.");
    }
  }

  @override
  Future<Details> productDetails(String id) async{
    final QueryOptions options = QueryOptions(
      document: gql(productDetailsQuery),
      variables: {
        'id': id
      }
    );
    final result = await client.query(options);
    if (result.hasException) {
      final exception = result.exception!;
      if(exception.linkException != null){
        throw Exception("La conexión es inestable.");
      }
      if(exception.graphqlErrors.isNotEmpty){
        final error = exception.graphqlErrors.first;
        throw Exception(error.message);
      }
    }
    final data = result.data?['viewProductsById'];
    Details details = Details(
      name: data['name'],
      price: data['price'].toDouble().toString(),
      imagePath: data['image'],
      description: data['description'],
      stock: data['stock'] ?? 0,
      seller: data['user']?['name'] ?? 'Anónimo'
    );
    return details;
  }

  @override
  Future<List> getProductsToBuy({int page = 1}) async{
    final QueryOptions options = QueryOptions(
      document: gql(getProductsToBuyQuery),
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        'first': 10,
        'page': page
      }
    );
    final result = await client.query(options);
    if (result.hasException) {
      final exception = result.exception!;
      if(exception.linkException != null){
        throw Exception("La conexión es inestable.");
      }
      if(exception.graphqlErrors.isNotEmpty){
        final error = exception.graphqlErrors.first;
        throw Exception(error.message);
      }
    }
    final data = result.data?['allProducts']['data'];
    List<Details> product_details = [];
    for (var item in data){
      product_details.add(Details(
          name: item['name'],
          price: item['price'].toDouble().toString(),
          imagePath: item['image'],
          stock: item['stock'],
          seller: item['user']?['name'] ?? 'Anónimo',
          id: item['id']
        )
      );
    }
    return product_details;
  }

  @override
  Future<List<VendorProduct>> getMyProducts() async {
    final QueryOptions options = QueryOptions(
      document: gql(myProductsQuery),
      fetchPolicy: FetchPolicy.noCache,
    );

    final result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> productsData = result.data?['myProducts'] ?? [];
    
    return productsData.map((json) => VendorProduct.fromJson(json)).toList();
  }

  @override
  Future<void> deleteProduct(String id) async {
    final MutationOptions options = MutationOptions(
      document: gql(deleteProductMutation),
      variables: {
        'id': id,
      },
      fetchPolicy: FetchPolicy.noCache,
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }
}
