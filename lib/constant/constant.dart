// datatabases

import 'package:cloud_firestore/cloud_firestore.dart';

var userDb = FirebaseFirestore.instance.collection("users");

var categoryDb = FirebaseFirestore.instance.collection("category");

var productDb = FirebaseFirestore.instance.collection("product");

var orderDb = FirebaseFirestore.instance.collection("orders");

var addressDb = FirebaseFirestore.instance.collection("address");
