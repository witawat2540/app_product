import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class My_widget {

  static void showInSnackBar(
      String value, Stcolor, _scaffoldKey, bgcolor, seconds) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      // behavior: SnackBarBehavior.floating,
      elevation: 10,
      content: Text(
        value,
        style: GoogleFonts.mali(color: Stcolor),
      ),
      backgroundColor: bgcolor,
      duration: Duration(seconds: seconds),
    ));
  }

}