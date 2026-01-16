import 'dart:async';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/domain/datasources/auth_datasource.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/infrastructure/graphql/auth_mutations.dart';
class AuthDatasourceImpl implements AuthDatasource {
  late final GraphQLClient client;

  AuthDatasourceImpl(){
    // final httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql');
    final httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql');
    client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
  }
  
  @override
  Future<Map<String,dynamic>> registerUser(User user) async {
    try{
      final MutationOptions options = MutationOptions(
        document: gql(createUserMutation),
        variables: user.toMap(),
      );

      final result = await client
        .mutate(options)
        .timeout(const Duration(seconds: 12));


      if(result.hasException){
        if(result.exception!.linkException != null){
          return {"connection": "La conexión falló"};
        }
        if(result.exception!.graphqlErrors.isNotEmpty){
          var errors;
          for(var error in result.exception!.graphqlErrors){
            errors = error.extensions?['validation'];
          }
          return errors;
        }
      }
      print("Usuario creado: ${result.data?['createUser']}");
      return <String, dynamic>{};
    } on TimeoutException{
      return {"connection": "Revisa tu conexión"};
    } on SocketException{
      return {"connection": "Error en el servidor"};
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
      final exception = result.exception!;
      if (exception.linkException != null){
        throw Exception("La conexión es inestable");
      }
      if (exception.graphqlErrors.isNotEmpty) {
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
