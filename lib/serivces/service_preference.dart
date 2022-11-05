import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends GetxService {
  static late SharedPreferences _preferences;

  static const _keySaldo = 'userId';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future clear() async {
    _preferences.clear();
  }

  static Future setSaldo(int saldo) async {
    await _preferences.setInt(_keySaldo, saldo);
  }

  static int? getSaldo() {
    final data = _preferences.getInt(_keySaldo);

    if (data != null) return data;
    return null;
  }
}
