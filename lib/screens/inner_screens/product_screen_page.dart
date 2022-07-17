import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:laithapp/core/controller/userProfileController.dart';
import '/core/controller/newOrderController.dart';
import '/widgets/custom%20widgets/productWidget.dart';

class ProductPage extends StatelessWidget {
  final String productName;
  final String image;
  final int price;
  final int productId;
  final String discreption;
  final String storeId;
  ProductPage(this.productName, this.image, this.price, this.productId,
      this.discreption, this.storeId);
  @override
  Widget build(BuildContext context) {
    final controllerx = Get.find<UserProfileController>();
    final h = Get.find<NewOrderController>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: ExpandableTheme(
            data: const ExpandableThemeData(
              iconColor: Colors.blue,
              useInkWell: true,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProductWidget(
                      productName, image, price, productId, discreption),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          new Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton.extended(
                                heroTag: 'buy',
                                hoverColor: Colors.green,
                                elevation: 2,
                                backgroundColor: Colors.pinkAccent,
                                foregroundColor: Colors.white,
                                onPressed:
                                    FirebaseAuth.instance.currentUser == null
                                        ? () {
                                            Get.snackbar("خطاء",
                                                " الرجاء تسجيل الدخول اولاً");
                                          }
                                        : () async {
                                            await h.fatchStoreLocation(
                                                storeId,
                                                productName,
                                                image,
                                                price,
                                                productId);
                                          },
                                icon: Icon(Icons.monetization_on_outlined),
                                label: Text('شراء'),
                              ),
                            ),
                          ),
                          new Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new FloatingActionButton.extended(
                                heroTag: 'cart',
                                hoverColor: Colors.green,
                                elevation: 2,
                                backgroundColor: Colors.greenAccent,
                                foregroundColor: Colors.white,
                                onPressed: () {},
                                icon: Icon(Icons.add_shopping_cart_sharp),
                                label: Text('السلة'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
