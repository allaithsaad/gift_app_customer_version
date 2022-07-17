import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/controller/orderController.dart';
import '/screens/inner_screens/order_main_page.dart';

class CartOrderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        builder: (controller) => OrderController.orderList == null
            ? controller.getOrders()
            : new ListView.builder(
                itemCount: OrderController.orderList.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Wrap(
                          children: [
                            Card(
                              color: Colors.deepPurple[100],
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      DateTime(
                                              OrderController
                                                  .orderList[i].orderDate.year,
                                              OrderController
                                                  .orderList[i].orderDate.month,
                                              OrderController
                                                  .orderList[i].orderDate.day)
                                          .toString()
                                          .replaceAll('00:00:00.000', ''),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      '#' +
                                          OrderController.orderList[i].orderId
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        OrderController
                                            .orderList[i].productImage,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        OrderController
                                            .orderList[i].productName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        OrderController.orderList[i]
                                            .deliveryPlaceDiscretion,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                              thickness: 1,
                            ),
                            Stack(
                              children: [
                                Card(
                                  margin: EdgeInsets.all(0),
                                  elevation: 0,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  bottom: -5,
                                  child: Text(
                                    OrderController.orderList[i].totalPrice
                                            .toString() +
                                        'RY',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: OrderState(OrderController
                                        .orderList[i].orderState)),
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.to(() => OrderMainScreen(
                            OrderController.orderList[i].productName,
                            OrderController.orderList[i].orderId,
                            OrderController.orderList[i].orderDate.toString(),
                            OrderController
                                .orderList[i].deliveryPlaceDiscretion,
                            OrderController.orderList[i].productPrice
                                .toString(),
                            OrderController.orderList[i].deliveryPrice
                                .toString(),
                            (OrderController.orderList[i].productPrice +
                                    OrderController.orderList[i].deliveryPrice)
                                .toString(),
                            OrderController.orderList[i].productImage
                                .toString()));
                      },
                    ),
                  );
                }));
  }
}

Widget OrderState(int orderState) {
  Color color = Colors.white;
  String title = '';

  if (orderState == 0) {
    color = Colors.red;
    title = 'قيد المعالجه';
  }
  if (orderState == 1) {
    color = Colors.deepOrange;
    title = 'جاري التحضير';
  }
  if (orderState == 2) {
    color = Colors.green;
    title = 'جاري التوصيل ';
  }
  if (orderState == 3) {
    color = Colors.deepPurple;
    title = 'تم التوصيل ';
  }
  return Badge(
      padding: EdgeInsets.all(5),
      toAnimate: true,
      shape: BadgeShape.square,
      badgeColor: color,
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(0),
          topLeft: Radius.circular(10)),
      badgeContent: Text(
        title,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ));
}
