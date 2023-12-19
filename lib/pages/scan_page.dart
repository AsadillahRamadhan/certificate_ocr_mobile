import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _nomorController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _instansiController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _nomorController,
            decoration: InputDecoration(labelText: 'Nomor'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _namaController,
            decoration: InputDecoration(labelText: 'Nama'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _instansiController,
            decoration: InputDecoration(labelText: 'Instansi'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _tanggalController,
            decoration: InputDecoration(labelText: 'Tanggal'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _eventController,
            decoration: InputDecoration(labelText: 'Event'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Dapatkan nilai dari setiap controller
    String nomor = _nomorController.text;
    String nama = _namaController.text;
    String instansi = _instansiController.text;
    String tanggal = _tanggalController.text;
    String event = _eventController.text;

    // Lakukan sesuatu dengan nilai yang diperoleh, misalnya tampilkan dalam debug console
    print('Nomor: $nomor');
    print('Nama: $nama');
    print('Instansi: $instansi');
    print('Tanggal: $tanggal');
    print('Event: $event');
  }
}
