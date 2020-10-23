import 'package:controlc_shop/save_product.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Save_product(),
            )),
        child: Icon(
          Icons.add,
          //color: Colors.blue[400],
        ),
        //backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        title: Text("Product"),
        elevation: 20,
        backgroundColor: Colors.blue[400],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Card(
            elevation: 10,
            color: Colors.white,
            child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              title: Text(
                "Name Product",
                //style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Remark",
                //style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                "฿ 10.00",
                //style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
