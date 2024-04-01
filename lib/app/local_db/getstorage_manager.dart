import 'package:get_storage/get_storage.dart';

final class GetStorageManager {
  static final GetStorageManager _instance = GetStorageManager._internal();
  factory GetStorageManager() => _instance;
  GetStorageManager._internal();

  static final box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void> write(String key, dynamic value) async {
    await box.write(key, value);
  }

  static T? read<T>(String key) {
    return box.read<T?>(key);
  }

  static Future<void> remove(String key) async {
    await box.remove(key);
  }

  static Future<void> clear() async {
    await box.erase();
  }
}
