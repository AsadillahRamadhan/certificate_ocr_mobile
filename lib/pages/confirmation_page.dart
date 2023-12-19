import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import '../utils/data.dart';
import '../utils/edit.dart';
import 'dart:io';


class Confirmation extends StatefulWidget {
  final data;// Misalkan ini URL foto dari data

  Confirmation({
    required this.data,
  });

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  TextEditingController nomorController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController instansiController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomorController.text = widget.data['nomor'] != null ? widget.data['nomor'] : '';
    namaController.text = widget.data['nama'] != null ? widget.data['nama'] : '';
    instansiController.text = widget.data['instansi'] != null ? widget.data['instansi'] : '';
    eventController.text = widget.data['event'] != null ? widget.data['event'] : '';
    tanggalController.text = widget.data['tanggal'] != null ? widget.data['tanggal'] : '';
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
                Data.getNgrokURL().substring(0, Data.getNgrokURL().length - 3) + widget.data['link']
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
                Data.deleteData(context, widget.data['id'], false);
              },
              child: Text('Batal'),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            ElevatedButton(
              onPressed: () {
                var datas = {
                  'id': widget.data['id'],
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
        ),
      ),
      ),
    );
  }
}