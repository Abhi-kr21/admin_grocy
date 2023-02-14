import 'package:admin_grocy/controller/product_controller.dart';
import 'package:admin_grocy/enum/enum.dart';
import 'package:admin_grocy/models/product_model.dart';
import 'package:admin_grocy/screens/add_product_screen.dart';
import 'package:admin_grocy/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfProductScreen extends StatelessWidget {
  final String catId;
  const ListOfProductScreen({super.key, required this.catId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Product"),
        backgroundColor: Colors.redAccent,
      ),
      body: Consumer<ProductController>(
        builder: (context, productcontroller, child) {
          var product = productcontroller.productList[catId];
          if (!productcontroller.productStatusmap.containsKey(catId)) {
            print("conatin");
            productcontroller.setproducts(catId: catId);
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amberAccent,
              ),
            );
          } else {
            if (productcontroller.productStatusmap[catId] ==
                ProductStatus.NIL) {
              productcontroller.setproducts(catId: catId);
            }
            switch (productcontroller.productStatusmap[catId]!) {
              case ProductStatus.DONE:
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisSpacing: 10,
                    mainAxisExtent: 250,
                    //  childAspectRatio: 0.98,
                    crossAxisCount: 2,
                  ),
                  itemCount: productcontroller.productList[catId]!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                bestselling: product[index].bestselling,
                                trendig: product[index].trending,
                                frequentbuy: product[index].frequentbuy,
                                image: product[index].image,
                                // name: productcontroller.productList[catId]![index].productname,
                                name: product[index].productname,
                                price: product[index].prize,
                                quantity: product[index].qty,
                                weight: product[index].weigth!,
                                catId: catId,
                                index: index,
                                productId: product[index].productid,
                              ),
                            ));
                      },
                      child: Container(
                        height: 100,
                        width: 200,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                product![index].image,
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(product[index].productname),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Price ${product[index].prize.toString()}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Quantity ${product[index].qty.toString()}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                " Weight ${product[index].weigth.toString()}gm"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              case ProductStatus.LOADING:
                print("loading");
                return const Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.pink),
                );
              case ProductStatus.NIL:
                print("nil");
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyan,
                  ),
                );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductScreen(catId: catId),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
