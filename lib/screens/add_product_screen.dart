import 'dart:io';

import 'package:admin_grocy/controller/product_controller.dart';
import 'package:admin_grocy/models/category_model.dart';
import 'package:admin_grocy/models/product_model.dart';
import 'package:admin_grocy/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  final String catId;
  const AddProductScreen({super.key, required this.catId});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? selectedfile;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController frequentbuycontroller = TextEditingController();
  TextEditingController bestsellingcontroller = TextEditingController();
  TextEditingController trendingcontroller = TextEditingController();
  // Pick an image
  pickimage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                  labelText: "Product name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: pricecontroller,
              decoration: InputDecoration(
                  labelText: "price",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: weightcontroller,
              decoration: InputDecoration(
                  labelText: "weight",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: quantitycontroller,
              decoration: InputDecoration(
                  labelText: "quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              controller: trendingcontroller,
              decoration: InputDecoration(
                  labelText: "IsTrending",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              controller: bestsellingcontroller,
              decoration: InputDecoration(
                  labelText: "BestSelling",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              controller: frequentbuycontroller,
              decoration: InputDecoration(
                  labelText: "frequent buy",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "Choose image",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 5,
                ),
                (selectedfile != null)
                    ? Image.file(
                        File(selectedfile!.path),
                        height: 100,
                        width: 120,
                        fit: BoxFit.cover,
                      )
                    : IconButton(
                        onPressed: () async {
                          selectedfile = await pickimage();
                          setState(() {});
                        },
                        icon: Icon(Icons.add)),
              ],
            ),
          ),
          Consumer<ProductController>(
            builder: (context, productcontroller, child) {
              return MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  // Navigator.pop(context);
                  if (selectedfile != null) {
                    productcontroller.addproduct(
                        istrending: trendingcontroller.text.isNotEmpty,
                        frequentbuy: frequentbuycontroller.text.isNotEmpty,
                        bestselling: bestsellingcontroller.text.isNotEmpty,
                        categoryid: widget.catId,
                        name: namecontroller.text,
                        price: int.parse(pricecontroller.text),
                        quantity: int.parse(quantitycontroller.text),
                        weight: double.parse(weightcontroller.text),
                        selectedfile: selectedfile!);
                  }
                },
                child: Text("Submit"),
              );
            },
          )
        ]),
      ),
    );
  }
}
