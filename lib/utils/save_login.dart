import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/jwt_token.dart';
import 'dart:async';

class AuthHelper{
static final storage = FlutterSecureStorage();

static Future<void> saveLoginData(String token) async {
  await storage.write(key: 'token', value: token);
}

static void deleteLoginData() async {
  await storage.delete(key: 'token');
}

static bool getLoginData() {
  Completer<Map<String, String?>> completer = Completer<Map<String, String?>>();
  storage.read(key: 'token').then((token) {
    if(token != null){
      return true;
    }
  }).catchError((error){
    completer.completeError(error);
  });
  return false;
}
}
