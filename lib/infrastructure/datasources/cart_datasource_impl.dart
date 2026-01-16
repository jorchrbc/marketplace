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

  @override
  Future<Cart?> removeFromCart(String cartItemId) async {
    final MutationOptions options = MutationOptions(
      document: gql(removeFromCartMutation),
      variables: {
        'cart_item_id': cartItemId,
      },
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      print('Error removing from cart: ${result.exception}');
      return null;
    }

    if (result.data != null && result.data!['removeFromCart'] != null) {
      return Cart.fromJson(result.data!['removeFromCart']);
    }
    return null;
  }

  @override
  Future<Cart?> updateCartItem(String cartItemId, int quantity) async {
    final MutationOptions options = MutationOptions(
      document: gql(updateCartItemMutation),
      variables: {
        'cart_item_id': cartItemId,
        'quantity': quantity,
      },
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      print('Error updating cart item: ${result.exception}');
      return null;
    }

    if (result.data != null && result.data!['updateCartItem'] != null) {
      return Cart.fromJson(result.data!['updateCartItem']);
    }
    return null;
  }
}
