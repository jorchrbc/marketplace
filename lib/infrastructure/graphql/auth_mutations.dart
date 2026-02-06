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

const String viewProfileQuery = r'''
    query{
    me{
    id
    name
    email
    number
    email_verified_at
    created_at
    updated_at
    role{
    id
    name
    }

    products{
    id
    name
    price
    stock
    image
    description
    created_at
    updated_at
    user_id
    }
    }
    }
''';

const String updateProfile = r'''
  mutation{
  updateProfile(name: "string",phone_number: "string"){
  status
  message
  user{
  id
  name
  email
  number
  email_verified_at
  created_at
  updated_at
  }
  }
  }
''';