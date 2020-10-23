import 'package:controlc_shop/service/MyWidget.dart';
import 'package:controlc_shop/service/mytextinput.dart';
import 'package:controlc_shop/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[300],
        textTheme: GoogleFonts.maliTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class user {
  String email = '';
  String password = '';
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> key_form = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  user _user = user();
  FirebaseAuth auth = FirebaseAuth.instance;



  Future<UserCredential> signInWithGoogle() async {
   try{
     // Trigger the authentication flow
     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

     // Obtain the auth details from the request
     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

     // Create a new credential
     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );
     // Once signed in, return the UserCredential
     Navigator.pushReplacement(
       context,
       CupertinoPageRoute(
         builder: (context) => Product(),
       ),
     );
     return await FirebaseAuth.instance.signInWithCredential(credential);
   }catch(e){
     print(e);
   }
  }
  Login() async {
    key_form.currentState.save();
    if (_user.email.isEmpty || _user.password.isEmpty) {
      My_widget.showInSnackBar("กรุณากรอก Email&Password", Colors.white,
          _scaffoldKey, Colors.red, 4);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _user.email, password: _user.password);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => Product(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          My_widget.showInSnackBar("ไม่มีผู้ใช้งานนี้กรูณา Sign Up",
              Colors.white, _scaffoldKey, Colors.red, 4);
        } else if (e.code == 'wrong-password') {
          My_widget.showInSnackBar("กรุณากรอกรหัสผ่านให้ถูกต้อง", Colors.white,
              _scaffoldKey, Colors.red, 4);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return auth.currentUser != null
        ? Product()
        : Scaffold(
            key: _scaffoldKey,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: key_form,
                child: SafeArea(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        label("Email"),
                        mycontaner(
                          //key: key_form,
                          textInputType: TextInputType.emailAddress,
                          hintText: "กรอกอีเมล",
                          icon: Icons.email,
                          onSaved: (value) {
                            setState(() {
                              _user.email = value;
                            });
                          },
                        ),
                        buildSizedBox(),
                        label("Password"),
                        mycontaner(
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          hintText: "กรอกรหัสผ่าน",
                          onSaved: (value) {
                            setState(() {
                              _user.password = value;
                            });
                          },
                          icon: Icons.vpn_key,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 40,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => Login(),
                            color: Colors.white,
                            textColor: Colors.indigo,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 50),
                        ),
                        buildSizedBox2(),
                        Center(
                          child: Text(
                            "-OR-",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        buildSizedBox2(),
                        Login_by('images/icon/google.png',
                            "Continue with Google", () =>signInWithGoogle()),
                        buildSizedBox2(),
                        Login_by('images/icon/facebook.png',
                            "Continue with Facebook", () {}),
                        buildSizedBox(),
                        buildSizedBox(),
                        buildSizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account ?",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            FlatButton(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 20),
                              ),
                              textColor: Colors.white,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signin_Page(),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  SizedBox buildSizedBox2() {
    return SizedBox(
      height: 20,
    );
  }

  Container Login_by(namefile, text, Function ontab) {
    return Container(
      height: 40,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              namefile,
              height: 30,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        onPressed: ontab,
        color: Colors.white,
        textColor: Colors.indigo,
      ),
      margin: EdgeInsets.symmetric(horizontal: 50),
    );
  }

  SizedBox buildSizedBox() {
    return buildSizedBox2();
  }

  Container label(text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      height: 30,
      width: 50,
    );
  }
}

