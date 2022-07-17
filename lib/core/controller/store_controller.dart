import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/service/store_service.dart';
import '/model/store_model.dart';

class StoreController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  static List<StoreModel> get storeModel => _storeModel;
  static List<StoreModel> _storeModel = [];

  StoreController() {
    getService();
  }

  getService() async {
    _loading.value = true;

    await StoreService().getStore().then((value) {
      for (int i = 0; i < value.length; i++) {
        _storeModel.add(StoreModel.fromJson(value[i].data()));
        print(_storeModel.length);
      }
      _loading.value = false;
      update();
    });
  }
}
