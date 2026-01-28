import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/domain/datasources/order_datasource.dart';
import 'package:marketplace/domain/services/token_storage.dart';
import 'package:marketplace/infrastructure/graphql/order_mutations.dart';

class OrderDatasourceImpl implements OrderDatasource {
  late final GraphQLClient client;
  final TokenStorage tokenStorage;

  OrderDatasourceImpl({required this.tokenStorage}) {
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
  Future<bool> createOrder(String address, String paymentMethod, List<Map<String, dynamic>> items) async {
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
      return false;
    }

    final data = result.data;
    if (data != null && data['newOrder'] != null) {
      return true;
    }

    return false;
  }
}
