import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_page/screens/home.dart';
import 'package:login_page/screens/login.dart';
import 'package:login_page/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'home': (context) => MyHome()
    },
  ));
}
