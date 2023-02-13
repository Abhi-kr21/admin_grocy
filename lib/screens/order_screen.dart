import 'package:admin_grocy/controller/order_controller.dart';
import 'package:admin_grocy/enum/enum.dart';
import 'package:admin_grocy/screens/order_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders Screen"),
          backgroundColor: Colors.redAccent,
        ),
        body: Consumer<OrderController>(
          builder: (context, ordercontrolller, child) {
            if (ordercontrolller.orderstatus == OrderStatus.NIL) {
              ordercontrolller.fetchorders();

              return CircularProgressIndicator();
            } else {
              switch (ordercontrolller.orderstatus) {
                case OrderStatus.DONE:
                  //  print(ordercontrolller.orders.length);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: ordercontrolller.orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "Date:${ordercontrolller.orders[index].madeorderon.toDate()}"),
                            Text(
                                " Order id :${ordercontrolller.orders[index].orderid}"),
                            Text(
                                "User name:${ordercontrolller.orderuser[index].name}"),
                            Text(
                                "User pnumber:${ordercontrolller.orderuser[index].pnumber}"),
                            Text(
                                "State:${ordercontrolller.address[index].state}"),
                            Text(
                                "city:${ordercontrolller.address[index].city}"),
                            Text(
                                "Pincode:${ordercontrolller.address[index].pincode}"),
                            Text(
                                "Address${ordercontrolller.address[index].addressline}"),
                            Text("bill:${ordercontrolller.bill[index]}"),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderProductScreen(index: index),
                                    ));
                              },
                              child: Text("View Product"),
                            )
                          ],
                        ),
                      );
                    },
                  );

                case OrderStatus.LOADING:
                  return CircularProgressIndicator();
                case OrderStatus.NIL:
                  return CircularProgressIndicator();
              }
            }
          },
        ));
  }
}
