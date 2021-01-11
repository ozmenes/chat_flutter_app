
import 'package:chat_flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(userId: user.uid) : null;
  }

  // Sing in with Email
  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult _result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);
    FirebaseUser firebaseUser = _result.user;
    return _userFromFirebaseUser(firebaseUser);

    }catch(e){
      print('SignIn error ' + e.toString());
      return null;
    }
  }

  //Register with Email
  Future registerWithEmailAndPassword(String email,String password)async{
    try{
       AuthResult result = await _auth.createUserWithEmailAndPassword(
           email: email,
           password: password);
       FirebaseUser firebaseUser = result.user;
       return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print('Registration error ' + e.toString());
      return null;
    }
  }

  //
  Future resetPassword(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print('Reset Password error ' + e.toString());
      return null;
    }
  }

  //Sign Out
  Future SignOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print('Sign Out error ' + e.toString());
      return null;
    }
  }
}