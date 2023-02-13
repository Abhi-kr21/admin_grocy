import 'package:admin_grocy/controller/category_controller.dart';
import 'package:admin_grocy/enum/enum.dart';
import 'package:admin_grocy/screens/add_category%20_screen.dart';
import 'package:admin_grocy/screens/list_of_product.dart';
import 'package:admin_grocy/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categories Screen"),
          backgroundColor: Colors.redAccent,
        ),
        body: Consumer<CategoryController>(
          builder: (context, categoryController, child) {
            if (categoryController.categorystatus == CategoryStatus.NIL) {
              categoryController.setcategory();
            }
            switch (categoryController.categorystatus) {
              case CategoryStatus.DONE:
                return ListView.builder(
                  itemExtent: 130,
                  shrinkWrap: true,
                  itemCount: categoryController.categorylist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListOfProductScreen(
                                  catId: categoryController
                                      .categorylist[index].categoryid!),
                            ));
                      },
                      child: Container(
                        // height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.only(right: 20, top: 10, left: 20),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  categoryController.categorylist[index].image,
                                  //height: 100,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(categoryController
                                .categorylist[index].categoryname)
                          ],
                        ),
                      ),
                    );
                  },
                );
              case CategoryStatus.LOADING:
                return Center(child: CircularProgressIndicator());
              // return SizedBox();
              case CategoryStatus.NIL:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCategoryScreen(),
                ));
          },
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
        ));
  }
}
