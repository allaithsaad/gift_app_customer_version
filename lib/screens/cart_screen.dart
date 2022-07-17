import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/controller/orderController.dart';
import '/widgets/custom%20widgets/cartOrderWidget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderf = Get.find<OrderController>();
    orderf.getOrders();
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Obx(
          () => Text(
            orderf.orderNumbers.value == 0
                ? 'لا يوجد لديك طلبات'
                : ' لديك  ' +
                    orderf.orderNumbers.value.toString() +
                    '  مشتريات في السله ',
            style: TextStyle(fontSize: 20),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      body: CartOrderWidget(),
    );
  }
}
