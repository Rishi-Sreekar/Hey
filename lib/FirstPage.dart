import 'package:flutter/material.dart';
import 'SignIn.dart';
import 'SignUp.dart';
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper:MyClipper() ,
              child: Container(
                height:( MediaQuery.of(context).size.height)*0.5,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/YinYang.png'),),
            ),
            Align(
              alignment: Alignment(0,-0.75),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: SizedBox(
                  width: 200*(MediaQuery.of(context).size.width/411),
                  height: 60*(MediaQuery.of(context).size.height/825),
                  child: RaisedButton(
                    elevation: 10,
                    child: Text('Sign In', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20.0),),
                    color: Colors.white,
                    onPressed: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));

                      });

                    },
                  ),
                ),

              ),
            ),
            Align(
              alignment: Alignment(0,0.75),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: SizedBox(
                  width: 200*(MediaQuery.of(context).size.width/ 411),
                  height: 60*(MediaQuery.of(context).size.height/ 825),
                  child: RaisedButton(
                    child: Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0),),
                    color: Colors.black,
                    onPressed: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      });
                    },
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