import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/controller/product_controller.dart';
import '/screens/inner_screens/product_screen_page.dart';

import 'like_botton.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GetBuilder<ProductController>(
        builder: (controller) => ProductController.productModel == null
            ? controller.getProduct()
            : new GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ProductController.productModel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                primary: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                    child: SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: FadeInImage.assetNetwork(
                                            placeholder: 'loader.gif',
                                            image: ProductController
                                                .productModel[i].image))),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Badge(
                                    toAnimate: true,
                                    shape: BadgeShape.square,
                                    badgeColor: Colors.deepPurple,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(0),
                                        topLeft: Radius.circular(5)),
                                    badgeContent: Text(
                                        ProductController.productModel[i].price
                                                .toString() +
                                            'Ry',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Badge(
                                      padding: EdgeInsets.all(1),
                                      toAnimate: true,
                                      shape: BadgeShape.square,
                                      badgeColor: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(0),
                                          topRight: Radius.circular(10)),
                                      badgeContent: LikeBotton(ProductController
                                          .productModel[i].favorite)),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => {
                                Get.to(
                                    () => ProductPage(
                                          ProductController
                                              .productModel[i].name,
                                          ProductController
                                              .productModel[i].image,
                                          ProductController
                                              .productModel[i].price,
                                          ProductController
                                              .productModel[i].productId,
                                          ProductController
                                              .productModel[i].description,
                                          ProductController
                                              .productModel[i].storeId,
                                        ),
                                    preventDuplicates: false),
                              }),
                    )),
      ),
    );
  }
}
