import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '/core/controller/product_controller.dart';
import '/screens/inner_screens/product_screen_page.dart';
import '/widgets/custom%20widgets/like_botton.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('المفضله'),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
        ),
        body: GetBuilder<ProductController>(
            builder: (controller) => ProductController.isFaviorte == null
                ? controller.getFavorite()
                : new GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: ProductController.isFaviorte.length,
                    shrinkWrap: true,
                    primary: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, i) => GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          ProductController.isFaviorte[i].image,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          SpinKitCubeGrid(
                                        color: Colors.grey[50],
                                        size: 180,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  )),
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
                                          ProductController.isFaviorte[i].price
                                                  .toString() +
                                              'Ry',
                                          style:
                                              TextStyle(color: Colors.white)),
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
                                        badgeContent: LikeBotton(
                                            ProductController
                                                .isFaviorte[i].favorite)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () => Get.to(
                              () => ProductPage(
                                  ProductController.isFaviorte[i].name,
                                  ProductController.isFaviorte[i].image,
                                  ProductController.isFaviorte[i].price,
                                  ProductController.isFaviorte[i].productId,
                                  ProductController.isFaviorte[i].description,
                                  ProductController.isFaviorte[i].storeId),
                              preventDuplicates: false),
                        ))),
      ),
    );
  }
}
