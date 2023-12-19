import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/data.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers extends StatefulWidget {
  @override
  _ImagePickersState createState() => _ImagePickersState();
}

class _ImagePickersState extends State<ImagePickers> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gambar Sertifikat'),
      ),
      body: Center(
        child: _image == null
            ? Text('Belum ada gambar yang dipilih')
            : Image.file(_image!),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: adaFoto(_image),
      ),
    );
  }

  List<Widget> adaFoto(_image){
    print(_image);
    List<Widget> tombol = [];
    tombol.add(SizedBox(width: 20));
    tombol.add(FloatingActionButton(
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Pilih dari galeri',
            child: Icon(Icons.photo_library),
          ));
    tombol.add(SizedBox(width: 20));
    tombol.add(FloatingActionButton(
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Ambil foto',
            child: Icon(Icons.camera_alt),
          ));
    if(_image != null){
      tombol.add(SizedBox(width: 20));
      tombol.add(FloatingActionButton(
            onPressed: () => Data.predictData(context, _image),
            child: Icon(Icons.upload),
          ));
    } 
    return tombol;
}
}