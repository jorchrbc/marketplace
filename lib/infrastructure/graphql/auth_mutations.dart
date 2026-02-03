const String createUserMutation = r'''
  mutation CreateNewUser(
    $name: String!, 
    $email: String!, 
    $number: String!, 
    $password: String!, 
  ) {
    createUser(
      name: $name,
      email: $email,
      number: $number,
      password: $password,
    ) {
      name
      email
      number
    }
  }
''';

const String loginMutation = r'''
  mutation Login($login: String!, $password: String!) {
    login(login: $login, password: $password) {
      access_token
      token_type
      user {
        id
        name
        email
      }
    }
  }
''';

const String logoutMutation = r'''
  mutation Logout {
    logout
  }
''';
