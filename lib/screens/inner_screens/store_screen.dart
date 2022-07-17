import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/core/controller/product_controller.dart';
import '/screens/inner_screens/product_screen_page.dart';
import '/widgets/custom%20widgets/like_botton.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class StorePage extends StatelessWidget {
  final String image;
  final String name;
  StorePage({this.image, this.name});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: GetBuilder<ProductController>(
            builder: (controller) => Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    collapsedHeight: 90.0,
                    centerTitle: true,
                    shadowColor: Colors.black,
                    backgroundColor: Colors.white,
                    floating: false,
                    pinned: true,
                    expandedHeight: 300.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.all(0),
                      title: Card(
                        margin: EdgeInsets.all(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      starCount: 5,
                                      rating: 3,
                                      size: 20.0,
                                      isReadOnly: true,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      color: Colors.purple,
                                      borderColor: Colors.deepPurple,
                                      spacing: 0.0)
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' محل هديا',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.purple),
                                  ),
                                  Card(
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text('مفتوح',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      background: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SpinKitCubeGrid(
                          color: Colors.grey[50],
                          size: 180,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                      return new GestureDetector(
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
                                    imageUrl: ProductController
                                        .storeProductsModel[i].image,
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
                                        ProductController
                                                .storeProductsModel[i].price
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
                                          .storeProductsModel[i].favorite)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () => Get.to(
                            () => ProductPage(
                                ProductController.storeProductsModel[i].name,
                                ProductController.storeProductsModel[i].image,
                                ProductController.storeProductsModel[i].price,
                                ProductController
                                    .storeProductsModel[i].productId,
                                ProductController
                                    .storeProductsModel[i].description,
                                ProductController
                                    .storeProductsModel[i].storeId),
                            preventDuplicates: false),
                      );
                    }, childCount: ProductController.storeProductsModel.length),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
