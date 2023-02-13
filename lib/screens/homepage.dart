import 'package:admin_grocy/controller/bottom_nav_controller.dart';
import 'package:admin_grocy/screens/category_screen.dart';

import 'package:admin_grocy/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final route = [OrderScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: route[currentindex],
      body: Consumer<BottomNavigationController>(
        builder: ((context, controller, child) {
          return route[controller.currentindex];
        }),
      ),
      bottomNavigationBar: Consumer<BottomNavigationController>(
        builder: ((context, controller, child) {
          return BottomNavigationBar(
              elevation: 10,
              type: BottomNavigationBarType.shifting,
              currentIndex: controller.currentindex,
              onTap: (value) {
                controller.setindex(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: "Orders",
                    backgroundColor: Colors.redAccent),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category_rounded),
                    label: "Category",
                    backgroundColor: Colors.redAccent),
              ]);
        }),
      ),
    );
  }
}
