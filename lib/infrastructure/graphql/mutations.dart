const String createUserMutation = r'''
  mutation CreateNewUser(
    $name: String!, 
    $email: String!, 
    $number: String!, 
    $password: String!, 
    $role_id: ID!
  ) {
    createUser(
      name: $name,
      email: $email,
      number: $number,
      password: $password,
      role_id: $role_id
    ) {
      id
      name
      email
      role {
        name
      }
    }
  }
''';