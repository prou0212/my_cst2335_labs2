import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String login = "";
  static String password = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";

  static final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();

  static Future<void> saveData() async {
    await _prefs.setString("login", login);
    await _prefs.setString("password", password);
    await _prefs.setString("first name", firstName);
    await _prefs.setString("last name", lastName);
    await _prefs.setString("phone", phone);
    await _prefs.setString("email", email);
  }

  // If the value is null, use the empty string
  static Future<void> loadData() async {
    await _prefs.getString(login) ?? "";
    await _prefs.getString(password) ?? "";
    await _prefs.getString(firstName) ?? "";
    await _prefs.getString(lastName) ?? "";
    await _prefs.getString(phone) ?? "";
    await _prefs.getString(email) ?? "";
  }

}