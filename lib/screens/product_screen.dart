import 'package:admin_grocy/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  String image;
  String name;
  int price;
  int quantity;
  double weight;
  final catId;
  final index;
  final productId;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();

  ProductScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity,
      required this.weight,
      required this.catId,
      required this.index,
      required this.productId});

  @override
  Widget build(BuildContext context) {
    namecontroller.text = name;
    pricecontroller.text = price.toString();
    quantitycontroller.text = quantity.toString();
    weightcontroller.text = weight.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text("Product name"),
          backgroundColor: Colors.redAccent,
        ),
        body: Consumer<ProductController>(
          builder: (context, productcontroller, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    image,
                    height: 250,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                          labelText: "name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: pricecontroller,
                      decoration: InputDecoration(
                          labelText: "price",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: quantitycontroller,
                      decoration: InputDecoration(
                          labelText: "quantity",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: weightcontroller,
                      decoration: InputDecoration(
                          labelText: "weight",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Consumer<ProductController>(
                    builder: (context, productcontroller, child) {
                      return MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          productcontroller.productValueChanged(
                              name: namecontroller.text,
                              price: int.parse(pricecontroller.text),
                              quantity: int.parse(quantitycontroller.text),
                              weight: double.parse(weightcontroller.text),
                              categoryid: catId,
                              index: index,
                              productId: productId);
                        },
                        child: Text("Submit"),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ));
  }
}
