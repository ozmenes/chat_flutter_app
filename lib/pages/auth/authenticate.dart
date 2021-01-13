import 'package:chat_flutter_app/pages/register/register.dart';
import 'package:chat_flutter_app/pages/signin/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignInPage(toggleView);
    }else{
      return RegisterPage(toggleView);
    }
  }
}
