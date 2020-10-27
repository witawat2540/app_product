import 'package:controlc_shop/main.dart';
import 'package:controlc_shop/service/MyWidget.dart';
import 'package:controlc_shop/service/mytextinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin_Page extends StatefulWidget {
  @override
  _Signin_PageState createState() => _Signin_PageState();
}

class _Signin_PageState extends State<Signin_Page> {
  GlobalKey<FormState> key_form = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  user _user = user();

  Sing_up() async {
    key_form.currentState.save();
    if (_user.password.isNotEmpty || _user.email.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _user.email, password: _user.password)
            .then((value) {
          return;
        });
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          My_widget.showInSnackBar(
              "รหัสผ่านง่ายเกินไป", Colors.white, _scaffoldKey, Colors.red, 4);
        } else if (e.code == 'email-already-in-use') {
          My_widget.showInSnackBar(
              "มีผู้ใช้งานนี้แล้ว", Colors.white, _scaffoldKey, Colors.red, 4);
        }
      } catch (e) {
        print(e);
        My_widget.showInSnackBar(
            "เกิดข้อผิดพลาด", Colors.white, _scaffoldKey, Colors.red, 4);
      }
    } else {
      My_widget.showInSnackBar("กรุณากรอก Email&Password", Colors.white,
          _scaffoldKey, Colors.red, 4);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Center(
            child: Form(
              key: key_form,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Text(
                      "Sign Up",
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
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () => Sing_up(),
                      color: Colors.white,
                      textColor: Colors.indigo,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                  ),
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
              style: TextStyle(fontSize: 18),
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
