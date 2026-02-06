import 'dart:async';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/core/constants.dart';
import 'package:marketplace/domain/datasources/order_datasource.dart';
import 'package:marketplace/domain/services/token_storage.dart';
import 'package:marketplace/infrastructure/graphql/order_mutations.dart';
import 'package:marketplace/domain/entities/order_details.dart';
import 'package:marketplace/domain/entities/order_result.dart';

class OrderDatasourceImpl implements OrderDatasource {
  late final GraphQLClient client;
  final TokenStorage tokenStorage;

  OrderDatasourceImpl({required this.tokenStorage}) {
    final httpLink = HttpLink(endpoint);
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
  Future<OrderResult> createOrder(String address, String paymentMethod, List<Map<String, dynamic>> items) async {
    final MutationOptions options = MutationOptions(
      document: gql(createOrderMutation),
      variables: {
        'address': address,
        'payment_method': paymentMethod, // GraphQL Enum expectation might require a string here that matches the enum
        'items': items,
      },
      fetchPolicy: FetchPolicy.noCache,
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      print('Error creating order: ${result.exception}');
      // You might want to throw an exception here or return false
      return OrderResult(false);
    }

    final data = result.data;
    if (data != null && data['newOrder'] != null) {
      return OrderResult(true, data!['newOrder']['id']);
    }

    return OrderResult(false);
  }
  
  @override
  Future<OrderDetails> getOrderDetails(String id) async {
    try{
      final QueryOptions options = QueryOptions(
        document: gql(getOrderDetailsQuery),
        variables: {
          'id': id
        },
      );

      final result = await client.query(options);

      if (result.hasException) {
        final exception = result.exception!;
        if(exception.linkException != null){
          throw Exception('La conexión es inestable.');
        }
        if(exception.graphqlErrors.isNotEmpty){
          final error = exception.graphqlErrors.first;
          throw Exception(error.message);
        }
      }
      final data = result.data?['orderById'];
      if(data == null){
        throw Exception('No se pudieron recopilar los detalles del pedido');
      }
      final List<Map<String, dynamic>> products =
      (data['items'] as List)
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
      final OrderDetails orderDetails = OrderDetails(
        address: data['address'],
        status: data['status'],
        payment_method: data['payment_method'],
        sub_total: data['sub_total'].toDouble(),
        tax: data['tax'].toDouble(),
        shipping: data['shipping'].toDouble(),
        total: data['total'].toDouble(),
        products: products,
      );
      return orderDetails;
    } on TimeoutException {
      throw ("La solicitud está tardando más de lo esperado");
    } on SocketException {
      throw ("Error inesperado");
    }
  }
}
