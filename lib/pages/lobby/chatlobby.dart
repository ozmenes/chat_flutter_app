import 'package:chat_flutter_app/services/constants.dart';
import 'package:chat_flutter_app/services/database.dart';
import 'package:chat_flutter_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatLobby extends StatefulWidget {
  final String chatRoomId;
  ChatLobby(this.chatRoomId);
  @override
  _ChatLobbyState createState() => _ChatLobbyState();
}

class _ChatLobbyState extends State<ChatLobby> {
  TextEditingController messageTextEditingController= new TextEditingController();
  static String appBarTitle = "Chat Lobby";
  Database _database = new Database();
  Stream chatMessageStream;

  Widget chatMessageList(){
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          reverse: true,
          //scrollDirection: Axis.vertical,
          itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
            return SingleChildScrollView(
                child: Column(
                  children: [
                    MessageTile(snapshot.data.documents[index]
                        .data["message"],
                      snapshot.data.documents[index]
                        .data["sendBy"] == Constants.myName,
                    ),
                  ],
                ),
            );
          },
        ) : Container();
      },
    );

  }
  sendMessage(){
    if(messageTextEditingController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
        "message" : messageTextEditingController.text,
        "sendBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch,
      };
      _database.addConversationMessage(widget.chatRoomId, messageMap);
    }
    messageTextEditingController.clear();
  }

  @override
  void initState() {
    _database.getConversationMessage(widget.chatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, appBarTitle),
      body: Container(
        child: Stack(
          children: [
               Padding(
                 padding: EdgeInsets.only(bottom: 100.0),
                   child: chatMessageList()
               ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                //color: Colors.grey[700],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autocorrect: true,
                          controller: messageTextEditingController,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                          decoration: messageFieldInputDecoration("Message..."),
                        ),
                      ),
                      SizedBox(width: 15.0,),
                      GestureDetector(
                        onTap: (){
                          sendMessage();
                         // messageTextEditingController.text.isEmpty ? Container() : sendMessage();// message bossa bos veri pushlamasin diye
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xff007EF4),
                                  const Color(0xff2A75BC)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.send,color: Colors.white,size: 28.0,),
                        ),
                      ),
                      //Image.asset("assets/images/search_white.png")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 80 : 18,right: isSendByMe ? 18 : 80),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              const Color(0xff007EF4),
              const Color(0xff2A75BC)
            ]:[
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF)
            ],
          ),
          borderRadius: isSendByMe ?
              BorderRadius.only(
                topLeft: Radius.circular(23.0),
                topRight: Radius.circular(23.0),
                bottomLeft: Radius.circular(23.0)
              ): BorderRadius.only(
                topLeft: Radius.circular(23.0),
                topRight: Radius.circular(23.0),
                bottomRight: Radius.circular(23.0)
          ),
        ),
          padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
          child: Text(message,style: simpleTextFieldStyle(),)),
    );
  }
}

