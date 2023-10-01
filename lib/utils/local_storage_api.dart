import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageApi {
  late SharedPreferences _prefs;

  LocalStorageApi() {
    initPrefs();
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get storage {
    return _prefs;
  }

  set token(String value) {
    _prefs.setString('token', value);
  }
}

final localStorage = LocalStorageApi();
