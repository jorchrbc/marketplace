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

  Future<void> loginUser(String email, String password) {
    // Implement login logic here
    throw UnimplementedError();
  }

}