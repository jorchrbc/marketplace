import 'dart:async';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/core/constants.dart';
import 'package:marketplace/domain/datasources/auth_datasource.dart';
import 'package:marketplace/domain/entities/user.dart';
import 'package:marketplace/domain/services/token_storage.dart';
import 'package:marketplace/infrastructure/graphql/auth_mutations.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final TokenStorage tokenStorage;

  AuthDatasourceImpl({required this.tokenStorage});

  /// Crea un cliente GraphQL dinámicamente para usar siempre el token actual
  GraphQLClient get client {
    final httpLink = HttpLink(endpoint);
    final authLink = AuthLink(
      getToken: () async {
        final token = await tokenStorage.getToken();
        return token != null ? token : null;
      },
    );

    return GraphQLClient(
      link: authLink.concat(httpLink),
      cache: GraphQLCache(),
    );
  }

  @override
  Future<Map<String, dynamic>> registerUser(User user) async {
    try {
      final options = MutationOptions(
        document: gql(createUserMutation),
        variables: user.toMap(),
      );

      final result = await client.mutate(options).timeout(
            const Duration(seconds: 6),
          );

      if (result.hasException) {
        if (result.exception!.linkException != null) {
          return {"connection": "La conexión falló"};
        }
        if (result.exception!.graphqlErrors.isNotEmpty) {
          var errors;
          for (var error in result.exception!.graphqlErrors) {
            errors = error.extensions?['validation'];
          }
          return errors;
        }
      }

      return <String, dynamic>{};
    } on TimeoutException {
      return {"connection": "Revisa tu conexión"};
    } on SocketException {
      return {"connection": "Error en el servidor"};
    }
  }

  @override
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try{
      final options = MutationOptions(
        document: gql(loginMutation),
        variables: {
          'login': email,
          'password': password,
        },
      );

      final result = await client.mutate(options).timeout(
        const Duration(seconds: 6),
      );

      if (result.hasException) {
        final exception = result.exception!;
        if (exception.linkException != null) {
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
    } on TimeoutException{
      throw Exception("Está tardando más de lo esperado");
    } on SocketException {
      throw Exception("Ha ocurrido un error inesperado");
    }
  }

  @override
  Future<User> viewUser() async {
    final options = QueryOptions(
      document: gql(viewProfileQuery),
    );

    final result = await client.query(options);

    if (result.hasException) {
      final exception = result.exception!;
      if (exception.linkException != null) {
        throw Exception("La conexión es inestable");
      }
      if (exception.graphqlErrors.isNotEmpty) {
        final error = exception.graphqlErrors.first;
        throw Exception(error.message);
      }
    }

    final data = result.data?['me'];
    return User(
      name: data['name'],
      lastName: '',
      phone: data['number'],
      email: data['email'],
      password: '',
    );
  }

  @override
  Future<void> logoutUser() async {
    final options = MutationOptions(document: gql(logoutMutation));

    try {
      final result = await client.mutate(options).timeout(
            const Duration(seconds: 6),
          );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
    } on TimeoutException {
      throw Exception('Timeout al cerrar sesión');
    } on SocketException {
      throw Exception('Ocurrió un error inesperado');
    }
  }
}
