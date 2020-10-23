
import 'package:controlc_shop/main.dart';
import 'package:flutter/material.dart';

class Signin_Page extends StatefulWidget {
  @override
  _Signin_PageState createState() => _Signin_PageState();
}

class _Signin_PageState extends State<Signin_Page> {
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: Colors.blue[300],
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Text(
                      "Sign In",
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
                  ),
                  buildSizedBox(),
                  label("Password"),
                  mycontaner(
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    hintText: "กรอกรหัสผ่าน",
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
                        "Sign In",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                      color: Colors.white,
                      textColor: Colors.indigo,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                  ),
                  buildSizedBox2(),
                  Center(
                    child: Text(
                      "--OR--",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  buildSizedBox2(),
                  Login_by(
                      'images/icon/google.png', "Continue with Google", () {}),
                  buildSizedBox2(),
                  Login_by(
                      'images/icon/facebook.png', "Continue with Facebook", () {}),
                  buildSizedBox(),
                  buildSizedBox(),
                  buildSizedBox(),
                ],
              ),
            ),
          ),
        ));
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
