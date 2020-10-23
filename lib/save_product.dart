import 'package:controlc_shop/main.dart';
import 'package:flutter/material.dart';

class Save_product extends StatefulWidget {
  @override
  _Save_productState createState() => _Save_productState();
}

class _Save_productState extends State<Save_product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.save,
            //color: Colors.blue[400],
          ),
          backgroundColor: Colors.blue[400],
        ),
        appBar: AppBar(
          elevation: 20,
          title: Text("Add Product"),
          backgroundColor: Colors.blue[400],
        ),
        body: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: ListView(
//        padding: EdgeInsets.all(10),
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                backgroundColor: Colors.blue[400],
                radius: 90,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 150),
                child: FlatButton(
                  child: Text("Add Image"),
                  onPressed: () {},
                  textColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              mycontaner(
                icon: Icons.store,
                textInputType: TextInputType.text,
                hintText: "Name Product",
              ),
              SizedBox(
                height: 30,
              ),
              mycontaner(
                icon: Icons.attach_money,
                textInputType: TextInputType.text,
                hintText: "Price",
              ),
              SizedBox(
                height: 30,
              ),
              mycontaner(
                icon: Icons.details,
                textInputType: TextInputType.text,
                hintText: "Remark",
              )
            ],
          ),
        ));
  }
}
