import 'package:admin_grocy/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProductScreen extends StatelessWidget {
  OrderProductScreen({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
        ),
        body: Consumer<OrderController>(
          builder: (context, ordercontroller, child) {
            if (ordercontroller.product.isEmpty) {
              ordercontroller.fetchorderproduct();
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: ordercontroller.orderproduct[index].length,
                itemBuilder: (BuildContext context, int pndex) {
                  return Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.amberAccent,
                    child: Row(
                      children: [
                        Image.network(
                          ordercontroller.orderproduct[index][pndex].image,
                          height: 100,
                        ),
                        Column(
                          children: [
                            Text("Name : " +
                                ordercontroller
                                    .orderproduct[index][pndex].productname),
                            Text("price :" +
                                ordercontroller.orderproduct[index][pndex].prize
                                    .toString()),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
