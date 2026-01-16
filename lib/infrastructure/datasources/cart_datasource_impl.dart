import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/domain/datasources/cart_datasource.dart';
import 'package:marketplace/domain/entities/cart.dart';
import 'package:marketplace/domain/services/token_storage.dart';
import 'package:marketplace/infrastructure/graphql/cart_operations.dart';

class CartDatasourceImpl implements CartDatasource {
  late final GraphQLClient client;
  final TokenStorage tokenStorage;

  CartDatasourceImpl({required this.tokenStorage}) {
    final httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql');
    final authLink = AuthLink(
      getToken: () async {
        final token = await tokenStorage.getToken();
        return 'Bearer $token';
      },
    );

    final link = authLink.concat(httpLink);

    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  @override
  Future<Cart?> getMyCart() async {
    final QueryOptions options = QueryOptions(
      document: gql(myCartQuery),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    final result = await client.query(options);

    if (result.hasException) {
       // Manejo de errores básico
       print('Error getting cart: ${result.exception}');
       return null; 
    }

    if (result.data != null && result.data!['myCart'] != null) {
      return Cart.fromJson(result.data!['myCart']);
    }
    return null;
  }

  @override
  Future<Cart?> addToCart(String productId, int quantity) async {
    final MutationOptions options = MutationOptions(
      document: gql(addToCartMutation),
      variables: {
        'product_id': productId,
        'quantity': quantity,
      },
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      print('Error adding to cart: ${result.exception}');
      return null;
    }

    if (result.data != null && result.data!['addToCart'] != null) {
      return Cart.fromJson(result.data!['addToCart']);
    }
    return null;
  }
}
