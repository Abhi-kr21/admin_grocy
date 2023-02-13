import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderid;
  final String userid;
  final List<String> productlist;
  final Timestamp madeorderon;
  OrderModel({
    required this.orderid,
    required this.userid,
    required this.productlist,
    required this.madeorderon,
  });

  Map<String, dynamic> tojson() {
    return {
      'orderid': orderid,
      'userid': userid,
      'productlist': productlist,
      'madeorderon': madeorderon,
    };
  }

  factory OrderModel.fromjson(Map<String, dynamic> map) {
    return OrderModel(
      orderid: map['orderid'] as String,
      userid: map['userid'] as String,
      productlist: List<String>.from((map['productlist'] as List<dynamic>)),
      madeorderon: map['madeorderon'],
    );
  }
}
