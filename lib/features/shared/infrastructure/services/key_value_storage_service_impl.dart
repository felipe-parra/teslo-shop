import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.get(key);
  }

  @override
  Future<bool> revmoveKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) {
    final prefs = await getSharedPrefs();
    switch(T){
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
      default:
        throw UnimplementedError("Set not implemented for type ${T.runtimeType}")
    }
  }
}
