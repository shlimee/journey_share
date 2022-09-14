import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future setValue(String key, String value) async => await _storage
      .write(key: key, value: value, aOptions: _getAndroidOptions());

  static Future<String?> getValue(String key) async =>
      await _storage.read(key: key);

  static Future<void> deleteValue(String key) async =>
      await _storage.delete(key: key);
}

AndroidOptions _getAndroidOptions() =>
    const AndroidOptions(encryptedSharedPreferences: true);
