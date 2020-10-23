import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlc_shop/main.dart';
import 'package:controlc_shop/save_product.dart';
import 'package:controlc_shop/service/MyWidget.dart';
import 'package:controlc_shop/service/myaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Save_product(),
          ),
        ),
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          FlatButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
            child: Text("Sign out"),
            textColor: Colors.white,
          )
        ],
        elevation: 20,
        backgroundColor: Colors.blue[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: product.snapshots(includeMetadataChanges: true),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => snapshot
                    .connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: EdgeInsets.all(10),
                children: snapshot.data.documents
                    .map(
                      (DocumentSnapshot document) => Card(
                        elevation: 10,
                        color: Colors.white,
                        child: ListTile(
                          onTap: () => showCupertinoModalPopup(
                            context: context,
                            builder: (context) => myaction(
                              edit: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => Save_product(status: "edit",data: document,),
                                  )),
                              delete: () {
                                product
                                    .doc(document.documentID)
                                    .delete()
                                    .then((value) => My_widget.showInSnackBar(
                                        "ลบแล้ว",
                                        Colors.white,
                                        _scaffoldKey,
                                        Colors.red,
                                        5))
                                    .catchError((error) => print(error));
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          leading: document.data()['image'] != ''
                              ? CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  backgroundImage:
                                      NetworkImage(document.data()['image']),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.blue,
                                ),
                          title: Text(
                            document.data()['name_product'],
                          ),
                          subtitle: Text(
                            document.data()['Remark'],
                          ),
                          trailing: Text(
                            "฿ " + document.data()['Price'].toString(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
