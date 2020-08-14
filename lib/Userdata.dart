import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';

class UserData {

  final String uid,uid2;

  UserData({this.uid,this.uid2});

  final CollectionReference _userdata = Firestore.instance.collection('usersInfo');

  Future addUserInfo(String Email1,String Email2) async {
    return await _userdata.document(uid).setData({
      'email': Email1,
      'chatId':uid+uid2
    });
  }
  Future addUserInfo1(String Email1,String Email2) async {
    return await _userdata.document(uid2).setData({
      'email':Email2,
      'chatId':uid+uid2
    });
  }
  UsersData _usersDataFromSnapshot(DocumentSnapshot snapshot){
    return UsersData(
        userId: uid,
        ChatId: snapshot.data['chatId']
    );
  }

  Stream<UsersData> get usersdata{
    return _userdata.document(uid).snapshots()
        .map(_usersDataFromSnapshot);
  }
}