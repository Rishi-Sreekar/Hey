import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


import 'User.dart';


class MessageTile extends StatefulWidget {
  String s,uidAsInput;
  MessageTile({this.s,this.uidAsInput});
  @override
  _MessageTileState createState() => _MessageTileState(message: s,uidAS: uidAsInput);
}

class _MessageTileState extends State<MessageTile> {
  String message,uidAS;
  _MessageTileState({this.message,this.uidAS});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final user = Provider.of<User>(context);
    return Align(
      alignment:user.userId==uidAS?Alignment(.93,0):Alignment(-.93,0) ,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.transparent,
        ),
        padding: EdgeInsets.all(0),
//                               width:MediaQuery.of(context).size.width,

        constraints: BoxConstraints(maxWidth: (MediaQuery.of(context).size.width/411)*260),
        child: Material(
          elevation: 3.0,
          shadowColor: Colors.grey[700],
          color:user.userId==uidAS? Colors.white: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0,15,15,15),
            child: Text(message,style:GoogleFonts.sourceSansPro(fontSize: 20,fontWeight: FontWeight.w300,color:user.userId!=uidAS? Colors.white: Colors.black,),),
          ),
        ),
      ),
    );
  }
}
