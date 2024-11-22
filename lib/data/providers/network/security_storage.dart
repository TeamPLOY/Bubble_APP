import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityStorage {
  static final SecurityStorage _instance = SecurityStorage._internal();

  final FlutterSecureStorage storage = FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  factory SecurityStorage() {
    return _instance;
  }

  SecurityStorage._internal();

  Future<void> saveSecureToken(String key, String value) async {
    await storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<void> clearUserData() async {
    await storage.deleteAll(aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureToken(String key) async {
    return await storage.read(key: key,aOptions: _getAndroidOptions());
  }

  Future<void> deleteSecureToken(String key) async {
    await storage.delete(key: key,aOptions: _getAndroidOptions());
  }

  /// 키 존재 여부 확인 메서드
  Future<bool> containsKey(String key) async {
    return await storage.containsKey(key: key,aOptions: _getAndroidOptions());
  }
}
