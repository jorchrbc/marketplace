class User{
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String role;

  User({
    required this.name,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap(){
    return {
      "name": '$name $lastName',
      "email": email,
      "number": phone,
      "password": password,
      "role_id": ((role == 'Vendedor') ? 2 : 3).toString(),
    };
  }
}