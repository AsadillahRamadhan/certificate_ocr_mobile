import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  // void initState(){
  //   super.initState();
  //   Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  RegisterApp() )));
  // }
      Widget build(BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/ 4)),
              Image.asset(
                'assets/img/splash_logo.png',
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Padding(padding: EdgeInsets.only(bottom: 90)),
              CircularProgressIndicator(),
            ],
          )
            
        );
      }
}