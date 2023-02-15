import 'package:admin_grocy/controller/order_controller.dart';
import 'package:admin_grocy/enum/enum.dart';
import 'package:admin_grocy/screens/order_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});
  final Map<int, String> month = {
    1: "January",
    2: "february",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Orders Screen"),
          backgroundColor: Colors.redAccent,
        ),
        body: Consumer<OrderController>(
          builder: (context, ordercontrolller, child) {
            if (ordercontrolller.orderstatus == OrderStatus.NIL) {
              ordercontrolller.fetchorders();

              return const Center(child: CircularProgressIndicator());
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
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "Date:${ordercontrolller.orders[index].madeorderon.toDate().day} / ${month[ordercontrolller.orders[index].madeorderon.toDate().month]} / ${ordercontrolller.orders[index].madeorderon.toDate().year}"),
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
                              color: Colors.lightBlue[100],
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderProductScreen(index: index),
                                    ));
                              },
                              child: const Text("View Product"),
                            )
                          ],
                        ),
                      );
                    },
                  );

                case OrderStatus.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case OrderStatus.NIL:
                  return const CircularProgressIndicator();
              }
            }
          },
        ));
  }
}
