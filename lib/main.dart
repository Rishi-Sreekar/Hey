import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:u_n_me/chatPage.dart';
import 'package:u_n_me/wrapper.dart';
import 'AuthenticateFireBase.dart';
import 'MessageTile.dart';
import 'package:flutter/cupertino.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, // status bar color
  ));

  runApp(Home());

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider.value(
        value: Authenticate().user,
    child: MaterialApp(
    home: Wrapper()
    )
    );
  }
}


