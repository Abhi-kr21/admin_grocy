import 'dart:io';
import 'package:admin_grocy/constant/constant.dart';
import 'package:admin_grocy/enum/enum.dart';
import 'package:admin_grocy/models/product_model.dart';
import 'package:admin_grocy/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends ChangeNotifier {
  /// A map of string(category id) and list of product.
  Map<String, List<Product>> productList = {};

  /// A map of string(category id) and product status(enum).
  Map<String, ProductStatus> productStatusmap = {};
  addproduct(
      {required String name,
      required int price,
      required int quantity,
      required double weight,
      required XFile selectedfile,
      required String categoryid,
      required bool istrending,
      required bool bestselling,
      required bool frequentbuy}) async {
    String? imageurl =
        await getImageUrl(File(selectedfile.path), "products/${name}/");
    print("frequentbuy ${frequentbuy}");

    Product product = Product(
        bestselling: bestselling,
        frequentbuy: frequentbuy,
        trending: istrending,
        productname: name,
        productid: "",
        categoryid: categoryid,
        prize: price,
        qty: quantity,
        weigth: weight,
        image: imageurl!);

    var res = await productDb.add(product.tojson());
    await res.update({'productid': res.id});
    var c = productList[categoryid]!;
    c.add(product);
    notifyListeners();
  }

  setproducts({required String catId}) async {
    productStatusmap[catId] = ProductStatus.LOADING;
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
    List<Product> tempList = [];
    try {
      var productSnapshot =
          await productDb.where("categoryid", isEqualTo: catId).get();

      for (var product in productSnapshot.docs) {
        Product p = Product.fromJson(product.data());
        tempList.add(p);
      }
    } catch (e) {
      print(e);
    }
    productList[catId] = tempList;
    productStatusmap[catId] = ProductStatus.DONE;
    notifyListeners();
  }

  productValueChanged(
      {required bool trending,
      required bool bestselling,
      required bool frequentbuy,
      required String name,
      required int price,
      required int quantity,
      required double weight,
      required String categoryid,
      required int index,
      required String productId}) async {
    try {
      await productDb.doc(productId).update({
        "bestselling": bestselling,
        "frequentbuy": frequentbuy,
        "trending": trending,
        "productname": name,
        "prize": price,
        "quantity": quantity,
        "weight": weight,
      });
      productList[categoryid]![index].trending = trending;
      productList[categoryid]![index].frequentbuy = frequentbuy;
      productList[categoryid]![index].bestselling = bestselling;
      productList[categoryid]![index].productname = name;
      productList[categoryid]![index].prize = price;
      productList[categoryid]![index].qty = quantity;
      productList[categoryid]![index].weigth = weight;
    } catch (e) {
      print(e);
    }
    // Product p = Product(
    //     productname: name,
    //     productid: productId,
    //     categoryid: categoryid,
    //     prize: price,
    //     qty: quantity,
    //     weigth: weight,
    //     image: productList[categoryid]![index].image);
    // productDb.doc(productId).set(p.tojson());
    notifyListeners();
  }
}
