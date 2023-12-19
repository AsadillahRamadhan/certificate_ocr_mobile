import 'package:flutter/material.dart';
import 'dart:convert';
import 'jwt_token.dart';
import 'package:http/http.dart' as http;
import '../pages/home_page.dart';
import '../utils/data.dart';

class EditDataForm extends StatefulWidget {
  final data;// Misalkan ini URL foto dari data

  EditDataForm({
    required this.data,
  });

  @override
  _EditDataFormState createState() => _EditDataFormState();
}

class _EditDataFormState extends State<EditDataForm> {
  TextEditingController nomorController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController instansiController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.data['content']['link']);
    nomorController.text = widget.data['content']['nomor'] != null ? widget.data['content']['nomor'] : '';
    namaController.text = widget.data['content']['nama'] != null ? widget.data['content']['nama'] : '';
    instansiController.text = widget.data['content']['instansi'] != null ? widget.data['content']['instansi'] : '';
    eventController.text = widget.data['content']['event'] != null ? widget.data['content']['event'] : '';
    tanggalController.text = widget.data['content']['tanggal'] != null ? widget.data['content']['tanggal'] : '';
  }

  @override
  void dispose() {
    // Hapus controller saat widget tidak digunakan lagi untuk mencegah memory leak
    nomorController.dispose();
    namaController.dispose();
    instansiController.dispose();
    eventController.dispose();
    tanggalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Image.network(
                 Data.getNgrokURL().substring(0, Data.getNgrokURL().length - 3) + widget.data['content']['link']
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            TextFormField(
              controller: nomorController,
              decoration: InputDecoration(labelText: 'Nomor'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            TextFormField(
              controller: instansiController,
              decoration: InputDecoration(labelText: 'Instansi'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            TextFormField(
              controller: eventController,
              decoration: InputDecoration(labelText: 'Event'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            TextFormField(
              controller: tanggalController,
              decoration: InputDecoration(labelText: 'Tanggal'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage()
            )
          );
              },
              child: Text('Back'),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            ElevatedButton(
              onPressed: () {
                var datas = {
                  'id': widget.data['content']['id'],
                  'nomor': nomorController.text,
                  'nama': namaController.text,
                  'instansi': instansiController.text,
                  'event': eventController.text,
                  'tanggal': tanggalController.text
                };
                Data.updateData(datas, context);
              },
              child: Text('Simpan'),
            ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

void getDataEdit(context, id) async{
  Token token = new Token();
  String? jwtToken = await token.getTokenFromStorage();
  var url = Uri.parse('${Data.getNgrokURL()}/data/$id?token=$jwtToken'); 
  try {
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditDataForm(data: jsonDecode(response.body)),
                                  )
                                );
    } else {
      throw Exception('Gagal mengambil data sertifikat');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}
