import 'dart:io';

import 'package:admin_grocy/constant/constant.dart';
import 'package:admin_grocy/enum/enum.dart';
import 'package:admin_grocy/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../services/storage_services.dart';

class CategoryController extends ChangeNotifier {
  /// Creating a list of Category objects.
  List<Category> categorylist = [];
  CategoryStatus categorystatus = CategoryStatus.NIL;

  /// It fetches data from firestore and stores it in a list
  setcategory() async {
    List<Category> tempCategory = [];
    categorystatus = CategoryStatus.LOADING;
    await Future.delayed(const Duration(microseconds: 1));
    notifyListeners();
    try {
      var categorySnapshot = await categoryDb.get();
      for (var category in categorySnapshot.docs) {
        Category c = Category.fromJson(category.data());
        tempCategory.add(c);
      }
    } catch (e) {
      print(e);
    }
    categorylist = tempCategory;
    categorystatus = CategoryStatus.DONE;
    notifyListeners();
  }

  /// It adds a category to the database and then adds it to the list of categories.
  ///
  /// Args:
  ///   name (String): The name of the category
  ///   selectedfile (XFile): XFile
  addcategory({required String name, required XFile selectedfile}) async {
    try {
      String? imageurl =
          await getImageUrl(File(selectedfile.path), "${name}/images");
      Category category =
          Category(categoryid: "", categoryname: name, image: imageurl!);
      var res = await categoryDb.add(category.tojson());
      await res.update({'categoryid': res.id});
      await res.get().then((categorySnap) {
        categorylist.add(Category.fromJson(categorySnap.data()!));
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
