import 'file:///C:/Users/enesz/FlutterAndroidStudioProjects/chat_flutter_app/lib/pages/home/search.dart';
import 'package:chat_flutter_app/pages/auth/authenticate.dart';
import 'package:chat_flutter_app/pages/lobby/chatlobby.dart';
import 'package:chat_flutter_app/services/auth.dart';
import 'package:chat_flutter_app/services/constants.dart';
import 'package:chat_flutter_app/services/database.dart';
import 'package:chat_flutter_app/services/helperfunction.dart';
import 'package:chat_flutter_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Authentication authentication = new Authentication();
  String appBarTitle = "Home";
  Database _database = new Database();
  Stream chatRoomsStream;

  Widget chatRoomsList(){
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              return ChatRoomsTile(
                  snapshot.data.documents[index].data["chatRoomId"]
                      .toString().replaceAll("_", "")
                      .replaceAll(Constants.myName, ""),
                  snapshot.data.documents[index].data["chatRoomId"]
              );
            }
          ) : Container();
        },
    );
  }
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {
      _database.getChatLobbys(Constants.myName).then((value){
        setState(() {
          chatRoomsStream = value;
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
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
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0,left:15.0),
                  child: Text(""),
                   // Constants.myName.substring(0,1).toUpperCase(),),
                ))),
            SizedBox(width: 100,),
            Text('Chat App'),
            SizedBox(width: 75.0,)
          ],
        ),
        elevation: 15.0,
        actions: [
          GestureDetector(
            onTap: (){
              authentication.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> Authenticate()
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.exit_to_app
              ),
            ),
          ),
        ],
      ),
      body: chatRoomsList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>Search()
          ));
        },
      ),
    );
  }
}
class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatLobby(chatRoomId)
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 18.0),
        child:Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}",style: chatLobbyCharTextFieldStyle(),),
            ),
            SizedBox(width: 12.0,),
            Container(
              child: Text(userName, style: simpleTextFieldStyle(),),
            )
          ],
        ),
      ),
    );
  }
}
