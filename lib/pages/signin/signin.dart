import 'file:///C:/Users/enesz/FlutterAndroidStudioProjects/chat_flutter_app/lib/pages/home/home.dart';
import 'package:chat_flutter_app/services/auth.dart';
import 'package:chat_flutter_app/services/database.dart';
import 'package:chat_flutter_app/services/helperfunction.dart';
import 'package:chat_flutter_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  final Function toggle;
  SignInPage(this.toggle);

   @override
  _SignInPagePageState createState() => _SignInPagePageState();
}

class _SignInPagePageState extends State<SignInPage> {
  String appBarTitle="Sign In";
  final _formKey = GlobalKey<FormState>();

  HelperFunctions helperFunction = new HelperFunctions();
  Authentication _authentication = new Authentication();
  Database database = new Database();
  QuerySnapshot snapshotUserInfo;

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  bool isLoading =false;


  signIn(){
    if(_formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);
      
      // TODO function o get userDetails

      database.getUserByUserEmail(emailTextEditingController.text)
          .then((value){
        snapshotUserInfo = value;
        HelperFunctions
            .saveUserNameSharedPreference(snapshotUserInfo
            .documents[0].data["name"]);
      });

      _authentication.signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text).then((value) {
        if(value != null){

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home()
          ));
        }
    });
      setState(() {
        isLoading = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context,appBarTitle),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          padding: EdgeInsets.all(12.00),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter a valid Email' : null,
                        controller: emailTextEditingController,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: textFieldInputDecoration("Username or Phone Nummer"),
                      ),
                      SizedBox(height: 12.0,),
                      TextFormField(
                        validator: (val) => val.length <6 ? 'Enter a valid Password 6+ chars long ' : null,
                        controller: passwordTextEditingController,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: textFieldInputDecoration('Password'),
                      ),
                      SizedBox(height: 12.0,),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                        child: Text("Forget Password ?",style: simpleTextFieldStyle(),),
                      ),
                      SizedBox(height: 24.0,),
                      GestureDetector(
                        onTap: ()=>signIn(),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff007EF4),
                                    const Color(0xff2A75BC)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Text("Sign In",style: boldTextFieldStyle(),),
                        ),
                      ),
                      SizedBox(height: 18.0,),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text("Sign in with Google",style: TextStyle(color: Colors.black,fontSize: 17.0),),
                      ),
                      SizedBox(height: 18.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account ?',style: simpleTextFieldStyle(),),
                          //SizedBox(width: 5.0,),
                          GestureDetector(
                            onTap: (){
                              widget.toggle();
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text("Register now", style: underlineTextFieldStyle(),)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
