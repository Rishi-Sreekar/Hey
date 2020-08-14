import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_n_me/AuthenticateFireBase.dart';
import 'package:u_n_me/UserAndMessagePass.dart';
import 'package:u_n_me/Userdata.dart';
import 'MessageTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'User.dart';
import 'loading.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FocusNode focusNode=FocusNode();
  final Authenticate _auth=Authenticate();
  TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();


  String message='';
  Stream<QuerySnapshot> chats;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final user = Provider.of<User>(context);


    return StreamBuilder<UsersData>(
      stream: UserData(uid: user.userId).usersdata,

      builder: (context, snapshot) {
        if(snapshot.hasData){
          UsersData userData=snapshot.data;
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body :Stack(
              children: <Widget>[

                Align(
                  alignment: MediaQuery.of(context).viewInsets.bottom!=0?Alignment(0,-.25): Alignment(0,-.30),
                  child: Container(
                    height:  MediaQuery.of(context).viewInsets.bottom!=0?(MediaQuery.of(context).size.height/825)*400:(MediaQuery.of(context).size.height/825)*670,
                    child:  StreamBuilder(
                      stream: UserAndMessagePass(uid: user.userId,chatId: userData.ChatId).getChats(userData.ChatId),
                      builder: (context, snapshot){
                      return snapshot.hasData ?  ListView.builder(
//                        reverse: true,
                      shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index){
                        return Column(
                          children: <Widget>[
                            MessageTile(s:snapshot.data.documents[index].data["msg"],uidAsInput:snapshot.data.documents[index].data["uid"] ,),
                            SizedBox(height: (MediaQuery.of(context).size.height/825)*10,)
                          ],
                        );

                      }
                      ) : Text('empty');
                      },
                      ),

                  ),
                ),

                Align(
                  alignment: Alignment(0,.973),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,0, 0, 0),
                        child: Container(
                          width:(MediaQuery.of(context).size.width/411)*340,
                          child: TextField(
                            onTap: (){ setState(() {

                              FocusScope.of(context).requestFocus(focusNode);
                            }); },
                            onChanged: (val){
                              setState(() {
                                message=val;
                              });
                            },
                            controller: _controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(color: Colors.black)
                                ) ,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText:"message...",
                                hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                            maxLines: 2,
                            maxLengthEnforced: false,

                          ),
                        ),
                      ),
                      SizedBox(width: (MediaQuery.of(context).size.width/411)*10,),
                      FloatingActionButton (
                        onPressed: ()  {
                          setState(() {
                            if(message!='') {
                              UserAndMessagePass _messagePass = UserAndMessagePass(
                              uid: user.userId, chatId: userData.ChatId);
                              _messagePass.message(message, userData.ChatId);
                              message='';
                                                          }
                            _controller.clear();
                          });
                          Timer(
                            Duration(milliseconds: 1),
                                () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
                          );

                        },
                        child: Icon(Icons.send,color: Colors.white,),
                        //change with color of choice
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ),

                Material(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                  elevation: 10.0,
                  shadowColor: Colors.black,

                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                    child: Container(
                      height:( MediaQuery.of(context).size.height)*0.060,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(.96,-1),
                  child: IconButton(icon:Icon(Icons.power_settings_new),color: Colors.white ,
                    onPressed: ()async{
                      _auth.signOut();
                    },),
                ),
                Align(
                  alignment: Alignment(-.96, -.98),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/YinYang.png'),),
                ),
              ],
            ),
          ),
        );
    }else{

    return Loading();
    }

  }
    );
  }
}
