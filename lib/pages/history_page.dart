import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import '../utils/data.dart';
import '../utils/edit.dart';

class EventCardContainer {

  static FutureBuilder builder(){
  return FutureBuilder(
      future: Data.getCertificateData(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.black,
      ));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Tampilkan pesan error jika terjadi kesalahan
        } else {
          List<dynamic> map = snapshot.data;
          List<Widget> cards = [];
          if(map.length > 0 && map[0]['id'] != null){
            for(int i = 0; i < map.length; i++){
            cards.add(card(map[i], context));
            }
          } else {
            return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Tidak ada data',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
          }
          return SingleChildScrollView(
            child: Column(children: cards),
          );
        }
      },
    );


    
  }

  static Widget card(data, context){
    return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: GestureDetector(
      onTap: () {
      },
      child: Card(
  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  // Set the clip behavior of the card
  clipBehavior: Clip.antiAliasWithSaveLayer,
  // Define the child widgets of the card
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
      Image.network(
        Data.getNgrokURL().substring(0, Data.getNgrokURL().length - 3) + (data['link'] != null ? data['link'] : ''),
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      // Add a container with padding that contains the card's title, text, and buttons
      Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the card's title using a font size of 24 and a dark grey color
            Text(
              "${data['event'] != null ? data['event'] : 'N/A'}",
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[800],
              ),
            ),
            Text(
              "NO. ${(data['nomor'] != null ? data['nomor'] : 'N/A')}",
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            // Add a space between the title and the text
            Container(height: 10),
            // Display the card's text using a font size of 15 and a light grey color
            Text(
              'Diberikan kepada ${(data['nama'] != null ? data['nama'] : 'N/A')} pada ${(data['tanggal'] != null ? data['tanggal'] : 'N/A')} oleh ${(data['instansi'] != null ? data['instansi'] : 'N/A')}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
            // Add a row with two buttons spaced apart and aligned to the right side of the card
            Row(
              children: <Widget>[
                // Add a spacer to push the buttons to the right side of the card
                const Spacer(),
                // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    "EDIT",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    getDataEdit(context, data['id']);
                  },
                ),
                // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    "DELETE",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Konfirmasi Hapus'),
                  content: Text('Anda yakin ingin menghapus data ini?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Batal'),
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                    ),
                    TextButton(
                      child: Text('Hapus'),
                      onPressed: () {
                        Data.deleteData(context, data['id'], true);
                      },
                    ),
                  ],
                );
              },
            );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      // Add a small space between the card and the next widget
      Container(height: 5),
    ],
  ),
),
    ),
        );
  }
}


