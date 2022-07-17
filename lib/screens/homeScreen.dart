import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/controller/product_controller.dart';
import '/screens/controll_screen.dart';
import '/screens/inner_screens/product_screen_page.dart';
import '/widgets/custom%20widgets/carousel_home.dart';
import '/widgets/custom%20widgets/icon_button_home.dart';
import '/widgets/custom%20widgets/like_botton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference slidRef =
        FirebaseFirestore.instance.collection('slideshow');
    slidRef.get();

    return SafeArea(
        child: GetBuilder<ProductController>(
      builder: (controller) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ControllScreen()));
            return;
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                collapsedHeight: 60.0,
                centerTitle: true,
                shadowColor: Colors.black,
                backgroundColor: Colors.white,
                floating: false,
                pinned: true,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.all(0),
                    collapseMode: CollapseMode.parallax,
                    title: SizedBox(height: 70, child: Icon_butoon_home()),
                    background: Column(
                      children: [Carousel_home(), SizedBox(height: 20)],
                    )),
              ),
              NewHome()
            ],
          ),
        ),
      ),
    ));
  }
}

class NewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
        return GetBuilder<ProductController>(
          builder: (controller) => GestureDetector(
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
                          imageUrl: ProductController.productModel[i].image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SpinKitCubeGrid(
                            color: Colors.grey[50],
                            size: 180,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
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
                            ProductController.productModel[i].price.toString() +
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
                          badgeContent: LikeBotton(
                              ProductController.productModel[i].favorite)),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => Get.to(
                () => ProductPage(
                    ProductController.productModel[i].name,
                    ProductController.productModel[i].image,
                    ProductController.productModel[i].price,
                    ProductController.productModel[i].productId,
                    ProductController.productModel[i].description,
                    ProductController.productModel[i].storeId),
                preventDuplicates: false),
          ),
        );
      }, childCount: ProductController.productModel.length),
    );
  }
}
