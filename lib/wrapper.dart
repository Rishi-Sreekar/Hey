import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_n_me/chatPage.dart';
import 'FirstPage.dart';
import 'User.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    if (user == null) {
      return FirstPage();
    }else{
      return ChatPage();
    }
}
}
