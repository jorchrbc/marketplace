import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:marketplace/domain/services/token_storage.dart';

class TokenStorageImpl implements TokenStorage {
  final _storage = FlutterSecureStorage();
  static const _key = 'auth_token';

  @override
  Future<void> saveToken(String token) =>
      _storage.write(key: _key, value: token);

  @override
  Future<String?> getToken() =>
      _storage.read(key: _key);

  @override
  Future<void> deleteToken() =>
      _storage.delete(key: _key);
}
