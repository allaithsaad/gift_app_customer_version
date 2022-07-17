import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/model/homeSliderModel.dart';

class HomeSliderController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  static List<HomeSliderModel> get homeSlider => _getHomeSlider;
  static List<HomeSliderModel> _getHomeSlider = [];

  HomeSliderController() {
    getService();
  }

  final CollectionReference _silderRef =
      FirebaseFirestore.instance.collection('slideshow');
  Future<List<QueryDocumentSnapshot>> getSlider() async {
    var value = await _silderRef.get();
    return value.docs;
  }

  getService() async {
    _loading.value = true;
    await getSlider().then((value) {
      for (int i = 0; i < value.length; i++) {
        _getHomeSlider.add(HomeSliderModel.fromJson(value[i].data()));
      }
      _loading.value = false;
      update();
    });
  }
}
