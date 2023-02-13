import 'package:admin_grocy/controller/bottom_nav_controller.dart';
import 'package:admin_grocy/controller/category_controller.dart';
import 'package:admin_grocy/controller/order_controller.dart';
import 'package:admin_grocy/controller/product_controller.dart';
import 'package:admin_grocy/screens/add_category%20_screen.dart';

import 'package:admin_grocy/screens/homepage.dart';
import 'package:admin_grocy/screens/list_of_product.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => BottomNavigationController())),
        ChangeNotifierProvider(create: ((context) => CategoryController())),
        ChangeNotifierProvider(create: ((context) => ProductController())),
        ChangeNotifierProvider(create: ((context) => OrderController())),
      ],
      child: MaterialApp(
        home: Homepage(),
      ),
    );
  }
}
