import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loading.dart';
import 'FirstPage.dart';
import 'SignIn.dart';
import 'AuthenticateFireBase.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String op='';
  String Email='',Email1='',password1='';
  String password='';
  String error='';
  bool loading=false;
  final Authenticate _auth =Authenticate();
  final _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return loading? Loading():  Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
            children: [
              ClipPath(
                clipper:MyClipper() ,
                child: Container(
                  height:( MediaQuery.of(context).size.height)*0.55,
                  color: Colors.black,
                ),
              ),
              Align(
                alignment: Alignment(0,-0.90),
                child: SizedBox(
//                  width: 325,
                  child: Form(
                    key: _formKey,
                    child: Column(
//                        direction: Axis.vertical,
                      children: <Widget>[
                        SizedBox(
                          height:(MediaQuery.of(context).size.height/825)*15,
                        ),
                        Text("Enter other person's Email & password",style:GoogleFonts.sourceSansPro(fontSize: 20,fontWeight: FontWeight.w700,color:Colors.white)),
                        SizedBox(
                          height:(MediaQuery.of(context).size.height/825)*15,
                        ),

                        Container(
                          padding: EdgeInsets.zero,
                          width: 350*(MediaQuery.of(context).size.width/411),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(color: Colors.grey[200]) ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                        Container(

                          padding: EdgeInsets.zero,
                          width: 350*(MediaQuery.of(context).size.width/411),
                          decoration: BoxDecoration(
                            color: Colors.white,

                            border: Border(bottom: BorderSide(color: Colors.grey[200]) ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val)=>val.length<6? 'password must be atlest of 6 characters':null,
                              onChanged: (val){
                                setState(() {
                                  password=val;
                                });
                              } ,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:" password",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                              maxLines: 1,
                              maxLengthEnforced: false ,
                            ),
                          ),
                        ),
                        SizedBox(
                          height:(MediaQuery.of(context).size.height/825)*40,
                        ),
                        Text("Enter your Email & password",style:GoogleFonts.sourceSansPro(fontSize: 20,fontWeight: FontWeight.w700,color:Colors.white)),
                        SizedBox(
                          height:(MediaQuery.of(context).size.height/825)*40,
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          width: 350*(MediaQuery.of(context).size.width/  411),
                          decoration: BoxDecoration(                            color: Colors.white,
                            border: Border(bottom: BorderSide(color: Colors.grey[200]) ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (val){
                                setState(() {
                                  Email1=val;
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
                        Container(

                          padding: EdgeInsets.zero,
                          width: 350*(MediaQuery.of(context).size.width/411),
                          decoration: BoxDecoration(                            color: Colors.white,
                            border: Border(bottom: BorderSide(color: Colors.grey[200]) ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val)=>val.length<6? 'password must be atlest of 6 characters':null,
                              onChanged: (val){
                                setState(() {
                                  password1=val;
                                });
                              } ,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:" password",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                              maxLines: 1,
                              maxLengthEnforced: false ,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0*(MediaQuery.of(context).size.height/825)),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 12.0*(MediaQuery.of(context).size.height/825)),
                        Text(
                          op,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0,0.77),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: SizedBox(
                    width: 200*(MediaQuery.of(context).size.width/411),
                    height: 60*(MediaQuery.of(context).size.height/825),
                    child: RaisedButton(
                      child: Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0),),
                      color: Colors.black,
                      onPressed: () async{
                        setState(() {
                          loading=true;
                        });
                        if(_formKey.currentState.validate()){
                          dynamic result=await _auth.signUp(Email,password,Email1,password1);

                          if(result==null){
                            setState(() {
                              error='Enter a valid Email';
                              loading=false;
                            });
                          }
                        }
                        Navigator.pop(context);
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
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
    Offset  CoSoP=Offset(0,size.height);
    Offset  CoEoP=Offset(size.width,size.height);
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