import 'package:http/http.dart' as http;
import 'package:login_register_app/pages/home_page.dart';
import 'dart:convert';
import 'jwt_token.dart';
import 'dart:async';
import '../utils/message.dart';
import 'package:flutter/material.dart';
import '../pages/confirmation_page.dart';
import 'dart:io';
import '../pages/loading.dart';

class Data{
  
static Future<Map<String, dynamic>> fetchUserData() async {
  Token token = new Token();
  String? jwtToken = await token.getTokenFromStorage();
  print(jwtToken);
  var url = Uri.parse('${getNgrokURL()}/user'); 
  var headers = {
    'Authorization': 'Bearer $jwtToken',
    'Content-Type': 'application/json',
  };

  try {
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data user');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

static Future<List<dynamic>> getCertificateData() async {
  Token token = new Token();
  String? jwtToken = await token.getTokenFromStorage();
  var url = Uri.parse('${getNgrokURL()}/data?token=$jwtToken'); 
  try {
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if(jsonDecode(response.body) is Map<String, dynamic>){
        List<dynamic> parsed = [jsonDecode(response.body)];
        return parsed;
      } else {
        List<dynamic> parsed = jsonDecode(response.body);
        return parsed;
      }
      
    } else {
      throw Exception('Gagal mengambil data sertifikat');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
  
}

static deleteData(context, id, isHome) async {
  Token token = new Token();
  String? jwtToken = await token.getTokenFromStorage();
  var url = Uri.parse('${getNgrokURL()}/data/${id.toString()}'); // Ganti dengan URL endpoint yang sesuai
  var headers = {
    'Authorization': 'Bearer $jwtToken',
    'Content-Type': 'application/json',
  };

   try {
    var response = await http.delete(
      url,
      headers: headers,
    );
    var result = jsonDecode(response.body);
    if(isHome){
      Message mes = new Message();
    mes.message(context, result['message']);
    }
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
  } catch (error){
    throw Exception('Error: $error');
  }
}

static String getNgrokURL(){
  return 'https://0b2a-2a09-bac5-3a1a-16d2-00-246-3b.ngrok-free.app/api';
}

static updateData(data, context) async {
  Token token = new Token();
  String? jwtToken = await token.getTokenFromStorage();
  var url = Uri.parse('${getNgrokURL()}/data/${data['id']}'); 
 
  var body = {
    'Authorization': 'Bearer $jwtToken',
    'Content-Type': 'application/x-www-form-urlencoded',
    'nomor': '${data['nomor']}',
    'nama': '${data['nama']}',
    'instansi': '${data['instansi']}',
    'event': '${data['event']}',
    'tanggal': '${data['tanggal']}'
  };

  try {
    var response = await http.put(
      url,
      body: body,
    );
    var result = jsonDecode(response.body);
    Message mes = new Message();
    mes.message(context, result['message']);
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
  } catch (error){
    throw Exception('Error: $error');
  }
  }

  static predictData(context, File image) async {
  Token token = new Token();
  String? jwtToken = await token.getTokenFromStorage();
  var url = Uri.parse('${getNgrokURL()}/predict?token=$jwtToken'); 
  var request = http.MultipartRequest('POST', url);
  request.files.add(
    await http.MultipartFile.fromPath(
      'photo',
      image.path,
    )
  );
  try {
    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoadingPage(),
                                  )
                                );
    var response = await request.send();
    var result = await http.Response.fromStream(response);
  

    if (result.statusCode == 200 || result.statusCode == 201) {
        Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Confirmation(data: jsonDecode(result.body)),
                                  )
                                );
      }
 else {
        List<dynamic> parsed = jsonDecode(result.body).toList();
        return parsed;
      }
  } catch (error) {
    throw Exception('Error: $error');
  }
  
}

  // Future uploadImage(File imageFile) async {
  //   final uri = Uri.parse('YOUR_API_ENDPOINT');
  //   var request = http.MultipartRequest('POST', uri);
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       'image',
  //       imageFile.path,
  //       contentType: MediaType('image', 'jpeg'),
  //     ),
  //   );

  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       // Berhasil mengirim gambar
  //       print('Gambar berhasil diunggah');
  //     } else {
  //       // Gagal mengirim gambar
  //       print('Gagal mengunggah gambar');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

}