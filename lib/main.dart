import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_register_app/pages/home_page.dart';

import 'values/app_theme.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'values/app_constants.dart';
import 'values/app_routes.dart';
import 'utils/jwt_token.dart';
import 'utils/save_login.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login and Register UI',
      theme: AppTheme.themeData,
      initialRoute: isLogin(),
      navigatorKey: AppConstants.navigationKey,
      routes: {
        AppRoutes.loginScreen: (context) => const LoginPage(),
        AppRoutes.registerScreen: (context) => const RegisterPage(),
        AppRoutes.homeScreen: (context) => HomePage()
      },
    );
  }

  isLogin() {

    var token = AuthHelper.getLoginData();
    if(token){
      return AppRoutes.homeScreen;
    }  else {
      return AppRoutes.loginScreen;
    }
  }
}