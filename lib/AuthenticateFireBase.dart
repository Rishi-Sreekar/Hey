import 'package:firebase_auth/firebase_auth.dart';
import 'User.dart';
import 'Userdata.dart';

class Authenticate{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }
  //#7 4:30
  Stream<User>get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign up with email and password
   Future signUp (String email,String password,String email2, String password2 ) async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      AuthResult result1=await _auth.createUserWithEmailAndPassword(email: email2, password: password2);
      FirebaseUser user =result.user;
      FirebaseUser user1 =result1.user;
      await UserData(uid: user.uid,uid2:user1.uid).addUserInfo(email,email2);
      await UserData(uid: user.uid,uid2:user1.uid).addUserInfo1(email,email2);
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in
  Future signIn (String email,String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword (email: email, password: password);
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //Sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  }
}