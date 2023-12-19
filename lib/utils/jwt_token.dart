import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Token{
  Future<void> saveTokenToStorage(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwtToken', token);
  
  }

  Future<String?> getTokenFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwtToken');
}

bool isJwtTokenAvailable(){
  bool isAvailable = false;
  Completer<bool> completer = Completer<bool>();

  SharedPreferences.getInstance().then((prefs) {
    String? jwtToken = prefs.getString('jwtToken');
    isAvailable = jwtToken != null && jwtToken.isNotEmpty;
    completer.complete(isAvailable);
  }).catchError((error) {
    completer.completeError(error);
  });
  completer.future.then((value) {
    isAvailable = value;
  });
  return isAvailable;
}
}


