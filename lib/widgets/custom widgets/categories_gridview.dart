import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/core/controller/product_controller.dart';
import '/screens/inner_screens/product_screen_page.dart';
import 'like_botton.dart';

class CategoriesGridWidget extends StatefulWidget {
  final x;
  CategoriesGridWidget(this.x);
  @override
  _CategoriesGridWidgetState createState() => _CategoriesGridWidgetState();
}

class _CategoriesGridWidgetState extends State<CategoriesGridWidget> {
  final cateRef = Get.find<ProductController>();
  @override
  void initState() {
    cateRef.getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GetBuilder<ProductController>(
        builder: (controller) => new GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: ProductController.cateModelId.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            primary: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: new GestureDetector(
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
                                    ProductController.cateModelId[i].image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => SpinKitCubeGrid(
                                  color: Colors.grey[50],
                                  size: 150,
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
                                    ProductController.cateModelId[i].price
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
                                      .cateModelId[i].favorite)),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => {
                            Get.to(
                                () => ProductPage(
                                      ProductController.cateModelId[i].name,
                                      ProductController.cateModelId[i].image,
                                      ProductController.cateModelId[i].price,
                                      ProductController
                                          .cateModelId[i].productId,
                                      ProductController
                                          .cateModelId[i].description,
                                      ProductController.cateModelId[i].storeId,
                                    ),
                                preventDuplicates: false),
                          }),
                )),
      ),
    );
  }
}
