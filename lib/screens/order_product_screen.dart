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
          backgroundColor: Colors.redAccent,
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
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              ordercontroller.orderproduct[index][pndex].image,
                              height: 100,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Name : ${ordercontroller.orderproduct[index][pndex].productname}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Price : ${ordercontroller.orderproduct[index][pndex].prize}"),
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
