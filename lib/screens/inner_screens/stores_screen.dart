import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/core/controller/product_controller.dart';
import '/core/controller/store_controller.dart';
import '/screens/inner_screens/store_screen.dart';

class StoresScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prodectController = Get.find<ProductController>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('المتاجر'),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
        ),
        body: GetBuilder<StoreController>(
            builder: (controller) => new GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: StoreController.storeModel.length,
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
                                  child: CachedNetworkImage(
                                    imageUrl: StoreController
                                        .storeModel[i].shopBackground,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        SpinKitCubeGrid(
                                      color: Colors.grey[50],
                                      size: 180,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                    ),
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
                                      StoreController.storeModel[i].name,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          prodectController.getStoreProduct(
                              StoreController.storeModel[i].storeId);
                          Get.to(StorePage(
                            image: StoreController.storeModel[i].shopBackground,
                            name: StoreController.storeModel[i].name,
                          ));
                        }),
                  ),
                )),
      ),
    );
  }
}
