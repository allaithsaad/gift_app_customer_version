import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '/model/location_model.dart';
import '/model/orderModel.dart';
import '/screens/controll_screen.dart';
import '/screens/inner_screens/orderScreen.dart';

import 'Network_Type.dart';
import 'userProfileController.dart';

class NewOrderController extends GetxController {
  final testConnection = Get.find<NetworkConnecationType>();
  RxString orderDelvreyLocationDiscrbtion = 'لايوجود موقع توصيل'.obs;
  RxString dateOfDelivry = 'لا يوجد تاريخ'.obs;
  RxString delivryHourName = 'لايوجد وقت'.obs;
  RxString delivryDayName = 'لايوجد تاريخ'.obs;
  RxString noteExixt = ''.obs;
  Rx<TimeOfDay> delivryHour = TimeOfDay(hour: 00, minute: 00).obs;
  Rx<DateTime> delivryDay = DateTime(1999, 9, 9).obs;
  LoactionsModel get orderDerivley => _orderDerivley;
  LoactionsModel _orderDerivley;
  double storeLocationLat;
  double storeLocationLong;
  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> fatchCurrentOrderDelvreyLocation(String documentId) async {
    testConnection.onInit();
    if (testConnection.connectionType != 0) {
      final CollectionReference _loactionsCollectionRef = _firebase
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('Locations');

      await _loactionsCollectionRef.doc(documentId).get().then((value) {
        _orderDerivley = LoactionsModel.fromJson(value.data());
        orderDelvreyLocationDiscrbtion.value =
            _orderDerivley.deliveryPlaceDiscretion;
        claculatDistanBeteenSotreAndCustomer();
        claculatTheDelivryPrice();

        update();
      });
    } else {
      Get.snackbar("إشهار", "تحقق من إتصالك بالانترنت ");
    }
  }

//  setValue(LoactionsModel s) {
//    orderDelvreyLocationDiscrbtion.value = s.deliveryPlaceDiscretion;
//    claculatDistanBeteenSotreAndCustomer();
//    claculatTheDelivryPrice();
//    update();
//  }

  double distanceInMeters;
  claculatDistanBeteenSotreAndCustomer() {
    distanceInMeters = Geolocator.distanceBetween(
        storeLocationLat,
        storeLocationLong,
        _orderDerivley.deliveryPostion.latitude,
        _orderDerivley.deliveryPostion.longitude);
    distanceInMeters = distanceInMeters / 10;
    distanceInMeters = distanceInMeters.roundToDouble();
    String x = distanceInMeters.toString();
    print("!!!!!!!!!!!!!!!!!!!!!!!xxxxxxxxxxxxxxxxxxxxxx!!!!!!!!!!!!!!!!!!!!");
    print(distanceInMeters.toString());
    print(
        "!!!!!!!!!!!!!xxxxxxxxxxxxxxxxxxxxxxxxx!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    Get.back();
  }

  RxDouble delivryPrice = 0.0.obs;
  RxString delivryPriceName = "لايوجد عنوان".obs;
  claculatTheDelivryPrice() {
    delivryPrice.value = distanceInMeters;
    delivryPriceName.value = delivryPrice.value.toString();
    update();
  }

  int productPrice;
  String productId;
  String productName;
  String productImage;
  Future<void> fatchStoreLocation(
      String storeId, productName, image, price, productId) async {
    this.productPrice = price;
    this.productId = productId.toString();
    this.productName = productName;
    this.productImage = image;
    try {
      await _firebase.collection('Store').doc(storeId).get().then((value) {
        GeoPoint x = value.get("storeLocation");
        storeLocationLat = x.latitude;
        storeLocationLong = x.longitude;
        print(storeLocationLat);
        print(storeLocationLong);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        Get.to(
            () => OrderScreen(productName, image, price, productId, storeId));
      });
    } catch (error) {
      Get.snackbar("error", error.toString());
    }
  }

  final UserProfileController local = Get.find();
  Random random = new Random();
  String orderId;
  OrderModel setOrderModel() {
    this.orderId = (random.nextInt(99999) * random.nextInt(99999)).toString();
    return OrderModel(
        userId: _auth.currentUser.uid,
        note: noteExixt.value,
        verified: false,
        deliveryBoyId: '',
        deliveryPrice: delivryPrice.value.round(),
        numberOfBuyer: _auth.currentUser.phoneNumber,
        productPrice: this.productPrice,
        productId: this.productId,
        orderId: this.orderId,
        deliveryPlaceDiscretion: orderDerivley.deliveryPlaceDiscretion,
        orderDate: DateTime.now(),
        orderState: local.userSPData.verifiedUser ? 1 : 0,
        paymentState: false,
        totalPrice: delivryPrice.value.round() + this.productPrice,
        paymentType: 'no awye',
        productName: this.productName,
        productImage: productImage,
        delvreyLocation: orderDerivley.deliveryPostion,
        storelocation: GeoPoint(storeLocationLat, storeLocationLong),
        dateOfDelivering: DateTime(
            delivryDay.value.year,
            delivryDay.value.month,
            delivryDay.value.day,
            delivryHour.value.hour,
            delivryHour.value.minute));
  }

  deleteData() {
    orderDelvreyLocationDiscrbtion.value = 'لايوجود موقع توصيل';
    dateOfDelivry.value = 'لا يوجد تاريخ';
    delivryPriceName.value = "لايوجد عنوان";
    delivryHourName.value = 'لايوجد وقت';
    delivryDayName.value = 'لايوجد تاريخ';
    delivryPrice.value = 0.0;
    noteExixt.value = '';
  }

  Future<void> addNewOrder(OrderModel orderModel) async {
    testConnection.getConnectionType();
    testConnection.onInit();
    if (testConnection.connectionType != 0) {
      if (orderDelvreyLocationDiscrbtion.value != 'لايوجود موقع توصيل') {
        if (dateOfDelivry.value != 'لايوجد تاريخ أو وقت للتوصيل ') {
          try {
            await _firebase
                .collection('Orders')
                .doc()
                .set(orderModel.toJson())
                .then((value) {
              deleteData();

              Get.defaultDialog(
                title: 'إشعار',
                content: Text("طلبك رقم $orderId قيد المراجعة "),
                onConfirm: () => Get.offAll(() => ControllScreen()),
              );
            });
          } catch (error) {
            Get.snackbar('error', error.toString());
          }
        } else {
          Get.snackbar("إشعار", "تأكد من إضافة تاريخ و وقت التوصيل");
        }
      } else {
        Get.snackbar("إشعار", "تأكد من إضافة موقع التوصيل ");
      }
    } else {
      Get.snackbar("إشعار", "تأكد من أتصالك بالانترنت");
    }
  }
}
