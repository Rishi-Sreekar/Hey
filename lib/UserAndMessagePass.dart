import 'package:cloud_firestore/cloud_firestore.dart';

import 'User.dart';

class UserAndMessagePass{
  String uid,chatId;
  UserAndMessagePass({this.uid,this.chatId});
   final CollectionReference _message=Firestore.instance.collection("ChatRooms");

   Future addChatRoom(String u2,String DocId) async{
    _message.document(DocId).setData({'user2':u2,'user1':uid});
   }
   Future message(String Message,String DocId) async{
     _message.document(DocId).collection("chats").add({'msg':Message,'uid':uid, 'time':DateTime.now().millisecondsSinceEpoch});


   }
   getChats(String chatRoomId) {
    return _message
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();

  }

}