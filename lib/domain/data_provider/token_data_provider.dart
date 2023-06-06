import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const _token = 'token';
  static const _email = 'email';
  static const _password = 'password';
}

class TokenDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getToken() async =>
      await _secureStorage.read(key: _Keys._token);
  Future<void> setToken(String? value) async {
    if (value != null) {
      await _secureStorage.write(key: _Keys._token, value: value);
    } else {
      await _secureStorage.delete(key: _Keys._token);
    }
  }

  Future<String?> getEmail() => _secureStorage.read(key: _Keys._email);
  Future<void> setEmail(String? value) {
    if (value != null) {
      return _secureStorage.write(key: _Keys._email, value: value);
    } else {
      return _secureStorage.delete(key: _Keys._email);
    }
  }

  Future<String?> getPassword() => _secureStorage.read(key: _Keys._password);
  Future<void> setPassword(String? value) {
    if (value != null) {
      return _secureStorage.write(key: _Keys._password, value: value);
    } else {
      return _secureStorage.delete(key: _Keys._password);
    }
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
