import 'package:chat_flutter_app/pages/lobby/chatlobby.dart';
import 'package:chat_flutter_app/services/constants.dart';
import 'package:chat_flutter_app/services/database.dart';
import 'package:chat_flutter_app/services/helperfunction.dart';
import 'package:chat_flutter_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String appBarTitle="Search";
  Database database = new Database();
  TextEditingController searchTextEditingController = new TextEditingController();
  QuerySnapshot searchSnapshot;
 String _myName;
  initiateSearch(){
    database.getUserByUsername(searchTextEditingController.text)
        .then((value){
      setState(() {
        searchSnapshot = value;
      });
      //print(value.toString);
    });
  }

  /// create chatlobby, send user to chatscreen. pushreplacement///
  createChatRoomAndStartConversation({String userName}){
    print("${Constants.myName}");
    if(userName != Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String,dynamic> chatRoomMap={
        "users": users,
        "chatRoomId" : chatRoomId,
      };
      database.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatLobby(
            chatRoomId
          )));
    }else{
      print("you can not send message to yourself");
    }
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return searchTile(
          userName: searchSnapshot.documents[index].data["name"],
          userEmail: searchSnapshot.documents[index].data["email"],
        );
      }
    ) : Container();
  }
  Widget searchTile({String userName, String userEmail}){
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: simpleTextFieldStyle(),),
              Text(userEmail,style: simpleTextFieldStyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(
                  userName: searchTextEditingController.text
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              child: Text("Message"),
            ),
          ),
        ],
      ),
    );
  }

  getUserInfo()async{
    _myName = await HelperFunctions.getUserNameSharedPreference();
  }
  @override
  void initState() {
    getUserInfo();
    initiateSearch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, appBarTitle),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
                    decoration: textFieldInputDecoration("Search"),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    initiateSearch();
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.0)
                    ),
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.search,color: Colors.white,size: 28.0,),
                  ),
                ),
                //Image.asset("assets/images/search_white.png")
              ],
            ),
            SizedBox(height: 16.0,),
            searchList(),
          ],
        ),
      ),
    );
  }
}
getChatRoomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}