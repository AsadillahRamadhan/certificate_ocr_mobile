import 'package:flutter/material.dart';
import 'package:login_register_app/pages/history_page.dart';
import 'package:login_register_app/pages/scan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'templates/navbar.dart';
import 'dart:async';
import 'dart:convert';
import '../utils/data.dart';
import 'loading.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  List catNames = [
    "Scaning",
    'History',
  ];

  List<Color> catColors = [
    Colors.blue,
    Colors.green,
  ];

  List<Icon> catIcons = [
    Icon(
      Icons.qr_code_scanner_rounded,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.history,
      color: Colors.white,
      size: 30,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: Data.fetchUserData(),
      builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage(); 
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
      final userData = snapshot.data;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 50),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 15, top: 20),
                child: Text(
                  "Selamat Datang, \n${userData != null ? userData['name']: ''}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    wordSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          ),),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 200,
            child: Padding(
            padding: EdgeInsets.only(left: 15, top: 20, bottom: 10),
            child: Text(
              "History",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  wordSpacing: 2),
            ),
          )
          ),
          Padding(
            padding: EdgeInsets.only(top: 275),
            child: Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: EventCardContainer.builder()
          ),
          )
          
        ],
      ),

      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigationBar(context)
    );
  }});
}
}