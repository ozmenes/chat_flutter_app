import 'package:chat_flutter_app/pages/auth/authenticate.dart';
import 'file:///C:/Users/enesz/FlutterAndroidStudioProjects/chat_flutter_app/lib/pages/home/home.dart';
import 'package:chat_flutter_app/services/helperfunction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn= false;
  @override
  void initState() {
    // TODO: implement initState
    getLoggedInState();
    super.initState();
  }
  getLoggedInState()async{
    await HelperFunctions.getUserLoggedInSharedPreference()
        .then((value){
          setState(() {
            userIsLoggedIn = value;
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //color: Colors.grey[900],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        //primaryColor: Color(0xff145C9E),
        //backgroundColor: Colors.black26,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      ///Multiple choose
      home:userIsLoggedIn != null ?
      /**/ userIsLoggedIn ? Home() :Authenticate()/**/
          : Authenticate(),
    );
  }
}
class IamBlank extends StatefulWidget {
  @override
  _IamBlankState createState() => _IamBlankState();
}

class _IamBlankState extends State<IamBlank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
