import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/domain/datasources/auth_datasource.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/infrastructure/graphql/mutations.dart';
class AuthDatasourceImpl implements AuthDatasource {
  final HttpLink httpLink;
  late final GraphQLClient client;

  AuthDatasourceImpl()
    : httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql') {
      client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
    }

  @override
  Future<void> registerUser(User user) async {
    final MutationOptions options = MutationOptions(
      document: gql(createUserMutation),
      variables: user.toMap(),
    );

    final result = await client.mutate(options);

    if(result.hasException){
      print('Error: ${result.exception.toString()}');
    } else {
      print("Usuario creado: ${result.data?['createUser']}");
    }
  }

  @override
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final MutationOptions options = MutationOptions(
      document: gql(loginMutation),
      variables: {
        'login': email,
        'password': password,
      },
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isNotEmpty) {
        throw Exception(result.exception!.graphqlErrors.first.message);
      }
      throw Exception(result.exception.toString());
    }

    final data = result.data?['login'];
    if (data == null) {
      throw Exception('Login failed: No data returned');
    }

    return data;
  }

  @override
  Future<void> logoutUser() async {
    final MutationOptions options = MutationOptions(
      document: gql(logoutMutation),
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }
}