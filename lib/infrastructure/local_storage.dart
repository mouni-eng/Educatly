import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static FlutterSecureStorage? secureStorage;

  static init() async {
    secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await secureStorage!.write(key: key, value: value);
    }
  }

  static Future<String?> getData({
    required String key,
  }) async {
    return await secureStorage?.read(key: key);
  }

  static void removeData({
    required String key,
  }) async {
    return await secureStorage!.delete(key: key);
  }
}

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    if(value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else {
      return await sharedPreferences!.setDouble(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences?.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async
  {
    return await sharedPreferences!.remove(key);
  }
}
