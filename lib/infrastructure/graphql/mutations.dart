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

const String createNewProduct = r'''
  mutation PublicarProducto($name: String!, $price: Float!, $image: Upload) {
  createProduct(name: $name, price: $price, image: $image) {
    id
    name
    price
    image_path
    created_at
  }
}
'''
;