import 'package:chat_flutter_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String appBarTitle = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context,appBarTitle),
      body: Container(
        color: Colors.grey[900],
      ),
    );
  }
}
