import 'package:admin_grocy/constant/constant.dart';
import 'package:admin_grocy/enum/enum.dart';
import 'package:admin_grocy/models/address_model.dart';
import 'package:admin_grocy/models/order_model.dart';
import 'package:admin_grocy/models/product_model.dart';
import 'package:admin_grocy/models/user_model.dart';

import 'package:flutter/cupertino.dart';

class OrderController extends ChangeNotifier {
  List<int> bill = [];
  List<AddressModel> address = [];
  List<UserModel> orderuser = [];
  List<UserModel> alluser = [];
  List<OrderModel> orders = [];
  List<Product> product = [];
  List<List<Product>> orderproduct = [];
  OrderStatus orderstatus = OrderStatus.NIL;

  fetchorders() async {
    orderstatus = OrderStatus.LOADING;
    await Future.delayed(Duration(microseconds: 1));
    notifyListeners();
    var orderSnapshots = await orderDb.get();
    // print(orderSnapshots);
    // print(" length   ${orderSnapshots.docs.length}");
    for (var order in orderSnapshots.docs) {
      var oid = order.id;
      // print("oid" + oid);
      var ordercollection =
          await orderDb.doc(oid).collection('totals orders').get();
      for (var o in ordercollection.docs) {
        OrderModel orderss = OrderModel.fromjson(o.data());
        orders.add(orderss);
      }
    }
    orders.sort(
      (a, b) => b.madeorderon.toDate().compareTo(a.madeorderon.toDate()),
    );
    await fetchorderproduct();
    setbill();
    await fetchaddress();
    orderstatus = OrderStatus.DONE;
    notifyListeners();
  }

  fetchallproduct() async {
    var productSnap = await productDb.get();
    for (var products in productSnap.docs) {
      Product p = Product.fromJson(products.data());
      product.add(p);
    }
    notifyListeners();
  }

  fetchorderproduct() async {
    await fetchallproduct();
    List<Product> temp = [];
    orders.forEach((order) {
      order.productlist.forEach((list) {
        product.forEach((products) {
          if (list == products.productid) {
            temp.add(products);
          }
        });
      });
      orderproduct.add(temp);
      temp = [];
    });
    notifyListeners();
  }

  fetchuser() async {
    var userSnap = await userDb.get();
    for (var user in userSnap.docs) {
      UserModel u = UserModel.fromJson(user);
      alluser.add(u);
    }
    notifyListeners();
  }

  fetchorderuser() async {
    await fetchuser();
    orders.forEach((order) {
      alluser.forEach((element) {
        if (order.userid == element.userid) {
          orderuser.add(element);
        }
      });
    });
    notifyListeners();
  }

  fetchaddress() async {
    await fetchorderuser();
    for (int i = 0; i < orderuser.length; i++) {
      var addressSnap = await addressDb.doc(orderuser[i].userid).get();
      AddressModel a = AddressModel.fromJson(addressSnap);
      address.add(a);
    }
    notifyListeners();
  }

  setbill() {
    orderproduct.forEach((element) {
      int total = 0;
      element.forEach((product) {
        total += product.prize;
      });
      bill.add(total);
    });
    notifyListeners();
  }
}
