import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class My_select_picker extends StatelessWidget {
  final Function camera, gallery;

  const My_select_picker({Key key, this.camera, this.gallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("เลือกรายการที่ต้องการ"),
      actions: [
        CupertinoActionSheetAction(
          onPressed: camera,
          child: Text(
            "Camera",
            style: GoogleFonts.niramit(),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: gallery,
          child: Text(
            "Gallery",
            style: GoogleFonts.niramit(),
          ),
        )
      ],
      cancelButton: CupertinoDialogAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Cancel',
          style: GoogleFonts.niramit(),
        ),
      ),
    );
  }
}
