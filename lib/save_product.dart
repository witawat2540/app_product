import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controlc_shop/service/myselectpicker.dart';
import 'package:controlc_shop/service/mytextinput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Save_product extends StatefulWidget {
  final DocumentSnapshot data;
  final String status;

  const Save_product({
    Key key,
    this.data,
    this.status,
  }) : super(key: key);

  @override
  _Save_productState createState() => _Save_productState();
}

class Products {
  String name_product = '';
  int price = 0;
  String remark = '';
  String image = '';
}

class _Save_productState extends State<Save_product> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');
  GlobalKey<FormState> key_form = GlobalKey<FormState>();
  Products _products = Products();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  TextEditingController name_product = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController remark = TextEditingController();

  File _image;
  final picker = ImagePicker();

  get_data_edit() {
    setState(() {
      _products.image = widget.data["image"];
      name_product.text = widget.data["name_product"];
      price.text = widget.data["Price"].toString();
      remark.text = widget.data["Remark"];
    });
    //print(_products.image);
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        String name_flie = _image.path.split('/').last;
        upload(_image, name_flie);
        Navigator.pop(context);
      } else {
        print('No image selected.');
      }
    });
  }

  upload(image, name_flie) async {
    var storageReference =
        await storage.ref("product").child("$name_flie").putFile(image);
    var ref = storage.ref('product').child("$name_flie");
    var url = await ref.getDownloadURL();
    setState(() {
      _products.image = url;
    });
    print(_products.image);
  }

  add_product() async {
    key_form.currentState.save();
    print(_products.price.toString());
    return product
        .add({
          'name_product': _products.name_product,
          'Price': _products.price,
          'Remark': _products.remark,
          'image': _products.image
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to add user: $error"));
  }

  update_product() async {
    key_form.currentState.save();
    print(_products.price.toString());
    return product
        .doc(widget.data.documentID)
        .updateData({
          'name_product': _products.name_product,
          'Price': _products.price,
          'Remark': _products.remark,
          'image': _products.image
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to add user: $error"));
    // return product
    //     .add({
    //       'name_product': _products.name_product,
    //       'Price': _products.price,
    //       'Remark': _products.remark,
    //       'image': _products.image
    //     })
    //     .then((value) => Navigator.pop(context))
    //     .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    if (widget.status == "edit") {
      get_data_edit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          if(widget.status == "edit"){
            update_product()
          }else{
            add_product()
          }
        },
        child: Icon(
          Icons.save,
        ),
        backgroundColor: Colors.blue[400],
      ),
      appBar: AppBar(
        elevation: 20,
        title: Text("Add Product"),
        backgroundColor: Colors.blue[400],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: key_form,
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              _image != null
                  ? CircleAvatar(
                      backgroundColor: Colors.blue[400],
                      radius: 90,
                      backgroundImage: FileImage(_image),
                    )
                  : widget.status == "edit" && _products.image == '' ||
                          widget.status == null
                      ? CircleAvatar(
                          backgroundColor: Colors.blue[400],
                          radius: 90,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.blue[400],
                          radius: 90,
                          backgroundImage: NetworkImage(_products.image),
                        ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 150),
                child: FlatButton(
                  child: Text("Add Image"),
                  onPressed: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => My_select_picker(
                      camera: () => getImage(ImageSource.camera),
                      gallery: () => getImage(ImageSource.gallery),
                    ),
                  ),
                  textColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              mycontaner(
                controller: name_product,
                icon: Icons.store,
                textInputType: TextInputType.text,
                hintText: "Name Product",
                onSaved: (String value) {
                  setState(() {
                    _products.name_product = value;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              mycontaner(
                controller: price,
                icon: Icons.attach_money,
                textInputType: TextInputType.number,
                hintText: "Price",
                onSaved: (String value) {
                  setState(() {
                    _products.price = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              mycontaner(
                controller: remark,
                icon: Icons.details,
                textInputType: TextInputType.text,
                hintText: "Remark",
                onSaved: (String value) {
                  setState(() {
                    _products.remark = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
