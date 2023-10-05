import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageApi {
  SharedPreferences? _prefs;

  LocalStorageApi() {
    initPrefs();
  }

  SharedPreferences? get storage => _prefs;

  initPrefs() {
    SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  setToken(String value) {
    if (storage != null) {
      storage!.setString("token", value);
    }
  }

  String getToken() {
    if (storage != null) {
      return storage!.getString("token") ?? "";
    }
    return "";
  }
}

final localStorage = LocalStorageApi();
