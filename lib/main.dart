import 'package:chat_flutter_app/pages/register/register.dart';
import 'package:chat_flutter_app/pages/signin/signin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      color: Colors.grey[900],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        //primaryColor: Color(0xff145C9E),
        backgroundColor: Colors.black26,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      home:RegisterPage(),
    );
  }
}
