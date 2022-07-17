import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/model/orderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  static List<OrderModel> get orderList => _orderlist;
  static List<OrderModel> _orderlist = [];
  RxInt orderNumbers = 0.obs;
  getOrders() async {
    _loading.value = true;
    _orderlist.clear();
    await FirebaseFirestore.instance
        .collection("Orders")
        .where('userId', isEqualTo: _auth.currentUser.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _orderlist.add(OrderModel.fromJson(element.data()));
      });
      _loading.value = false;
      orderNumbers.value = _orderlist.length;
      update();
    });
  }
}
