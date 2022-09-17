import 'package:get_storage/get_storage.dart';

class Preference {
  static final prefs = GetStorage();
  static const loggedInFlag = 'loginFlag';
  static bool getLoggedInFlag() {
    return prefs.read(loggedInFlag) ?? false;
  }

  static void setLoggedInFlag(bool value) {
    prefs.write(loggedInFlag, value);
  }

  static void clearAll() {
    prefs.erase();
  }
}
