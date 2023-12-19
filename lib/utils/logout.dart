import 'dart:convert';
import 'package:login_register_app/utils/save_login.dart';

import 'jwt_token.dart';
import 'package:http/http.dart' as http;
import '../utils/message.dart';
import 'data.dart';
logout(context) async {
  Token token = new Token();
  String? jwtToken = await token.getTokenFromStorage();
  var url = Uri.parse('${Data.getNgrokURL()}/logout'); // Ganti dengan URL endpoint yang sesuai
  var headers = {
    'Authorization': 'Bearer $jwtToken',
    'Content-Type': 'application/json',
  };

  try {
    var response = await http.post(
      url,
      headers: headers,
    );
    var result = jsonDecode(response.body);
    Message mes = new Message();
    mes.message(context, result['message']);
    AuthHelper.deleteLoginData();
    return true;
  } catch (error){
    throw Exception('Error: $error');
  }
  }
