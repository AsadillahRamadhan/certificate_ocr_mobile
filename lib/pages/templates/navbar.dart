import 'package:flutter/material.dart';
import 'package:login_register_app/pages/login_page.dart';
import '../../utils/data.dart';
import '../../utils/logout.dart';
import '../home_page.dart';
import 'dart:convert';
import '../../utils/jwt_token.dart';
import 'package:camera/camera.dart';
import '../camera_page.dart';

Widget floatingActionButton(context){
  return FloatingActionButton(
        onPressed: () async {
          await availableCameras().then((value) => Navigator.push(context,
          MaterialPageRoute(builder: (_) => new ImagePickers())));
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.document_scanner),
      );
}

Widget bottomNavigationBar(context){
  return BottomAppBar(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage()
            )
          );
          }, icon: Icon(Icons.home)),
          SizedBox(
            width: 20,
          ),
          IconButton(onPressed: () async {
            var success = await logout(context);
            if(success == true){
              Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage()
            )
          );
            }
            
          }, icon: Icon(Icons.logout))
        ]),
      );
}