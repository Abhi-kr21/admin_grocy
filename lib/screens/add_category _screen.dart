import 'dart:developer';
import 'dart:io';

import 'package:admin_grocy/controller/category_controller.dart';
import 'package:admin_grocy/models/category_model.dart';
import 'package:admin_grocy/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? selectedfile;
  TextEditingController namecontroller = TextEditingController();
  // Pick an image
  pickimage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: namecontroller,
            decoration: InputDecoration(
                labelText: "Category name",
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
        Consumer<CategoryController>(
          builder: (context, categoryController, child) {
            return MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                if (selectedfile != null) {
                  categoryController.addcategory(
                      name: namecontroller.text, selectedfile: selectedfile!);
                }

                // Navigator.pop(context);
              },
              child: Text("Submit"),
            );
          },
        )
      ]),
    );
  }
}
