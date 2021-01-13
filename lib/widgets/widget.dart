import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context,String appBarTitle){
  return AppBar(
    title: Text(appBarTitle),
    centerTitle: true,
    elevation: 15.0,
  );
}

InputDecoration messageFieldInputDecoration(String hinText){
  return InputDecoration(
    hintText: hinText,
    hintStyle: TextStyle(
      color: Colors.white60,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 0),
      gapPadding: 10,
      borderRadius: BorderRadius.circular(25.0),
    ),
  );
}
InputDecoration textFieldInputDecoration(String hinText){
  return InputDecoration(
    hintText: hinText,
    hintStyle: TextStyle(
      color: Colors.white60,
    ),
    enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white)
    ),
  );
}

TextStyle messageTextFieldStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17.0,
  );
}
TextStyle chatLobbyCharTextFieldStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17.0,
  );
}
TextStyle simpleTextFieldStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 16.0,

  );
}
TextStyle boldTextFieldStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 17.0,
      fontWeight: FontWeight.bold
  );
}
TextStyle underlineTextFieldStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 17.0,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
  );
}