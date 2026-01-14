class GraphQLClientFactory {
  static GraphQLClient create(AuthService authService) {
    final httpLink = HttpLink('https://rumpless-cooingly-beaulah.ngrok-free.dev/graphql');

    final authLink = AuthLink(
      getToken: () async {
        final token = await authService.getToken();
        return token != null ? 'Bearer $token' : null;
      },
    );

    return GraphQLClient(
      link: authLink.concat(httpLink),
      cache: GraphQLCache(),
    );
  }
}
