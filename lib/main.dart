import 'package:controlc_shop/product.dart';
import 'package:controlc_shop/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[300],
        textTheme: GoogleFonts.maliTextTheme(Theme.of(context).textTheme),
        primarySwatch:Colors.blue,
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blue[300],
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Product(),
                      )),
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
              Login_by('images/icon/google.png', "Login Form Google", () {}),
              buildSizedBox2(),
              Login_by(
                  'images/icon/facebook.png', "Login Form Facebook", () {}),
              buildSizedBox(),
              buildSizedBox(),
              buildSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account ?",
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
              style: TextStyle(fontSize: 20),
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

class mycontaner extends StatelessWidget {
  final icon;
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;

  const mycontaner({
    Key key,
    this.icon,
    this.hintText,
    this.textInputType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.blue[300].withAlpha(450),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        cursorColor: Colors.white,
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}
