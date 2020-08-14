import 'package:flutter/material.dart';
import 'loading.dart';
import 'AuthenticateFireBase.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obs=true;
  String Email='';
  String password='';
  String error='';
  bool loading=false;
  final Authenticate _auth =Authenticate();
  final _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body:loading? Loading() : SafeArea(
        child: Stack(
            children: [
              ClipPath(
                clipper:MyClipper() ,
                child: Container(
                  height:( MediaQuery.of(context).size.height)*0.35,
                  color: Colors.  black,
                ),
              ),
              Align(
                alignment: Alignment(0, -0.8),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/YinYang.png'),),
              ),
              Align(
                alignment: Alignment(0,-.15),
                child: SizedBox(
                  width: 325*(MediaQuery.of(context).size.width/  411),
                  child: Card(
                    elevation: .50,
                    child: Form(
                      key: _formKey,
                      child: Wrap(
                        children:<Widget>[

                          Align(
                            alignment: Alignment(0,-.2),
                            child: Container(
                              padding: EdgeInsets.zero,
                              width: 300*(MediaQuery.of(context).size.width/  411),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]),),),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5,0, 0, 0),
                                child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      Email=val;
                                    });
                                  },
                                  validator: (val)=>val.isEmpty? 'Enter a valid Email':null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:"  Email",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                  maxLines: 1,
                                  maxLengthEnforced: false ,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0,.30),
                            child: Container(
                              padding: EdgeInsets.zero,
                              width: 300*(MediaQuery.of(context).size.width/  411),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200])),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5,0, 0, 0),
                                child: TextFormField(
                                  validator: (val)=>val.length<6? 'password must be atlest of 6 characters':null,
                                  onChanged: (val){
                                    setState(() {
                                      password=val;
                                    });
                                  } ,
                                  obscureText: obs,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),
                                        onPressed: ((){
                                          setState(() {
                                            obs=!obs;
                                          });
                                        }),
                                        color: Colors.grey[350],
                                      ),
                                      border: InputBorder.none,
                                      hintText:"  Password",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                  maxLines: 1,
                                  maxLengthEnforced: false ,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0,0.77),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: SizedBox(
                    width: 200*(MediaQuery.of(context).size.width/  411),
                    height: 60*(MediaQuery.of(context).size.height/  825),
                    child: RaisedButton(
                      child: Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0),),
                      color: Colors.  black,
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          dynamic result= await _auth.signIn(Email,password);
                          setState(() {
                            loading=true;
                          });
                          if(result==null){
                            setState(() {
                              error='Email/password wrong please check';
                              loading=false;
                            });
                          }
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),

                ),
              ),
            ]

        ),
      ),
    );
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path =Path();
    Offset  CoSoP=Offset(0,size.height*.85);
    Offset  CoEoP=Offset(size.width,size.height*.85);
    path.lineTo(CoSoP.dx, CoSoP.dy);
    path.quadraticBezierTo(size.width*0.5, size.height, CoEoP.dx, CoEoP.dy);
    path.lineTo(size.width, 0);
    return  path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }


}