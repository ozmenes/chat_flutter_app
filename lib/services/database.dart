import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  getUserByUsername(String userName){
    return Firestore.instance.collection("users")
        .where("name", isEqualTo: userName)
        .getDocuments();
  }
  getUserByUserEmail(String userEmail){
    return Firestore.instance.collection("users")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }
  uploadUserInfo(userMap){
    Firestore.instance.collection("users")
        .add(userMap).catchError((e){
      print(e.toString());
      });
  }
  createChatRoom(String chatRoomId, chatRoomMap){
    return Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomMap).catchError(
        (e){
          print(e.toString());
        }
    );
  }
  addConversationMessage(String chatRoomId, messageMap){
    return Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e)=> print(e.toString()));
  }
  getConversationMessage(String chatRoomId)async{
    return await Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }
  getChatLobbys(String userName)async{
    return await Firestore.instance.collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();

  }
}