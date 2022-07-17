import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/model/categoryModel.dart';

class CategoriesController extends GetxController {
  static List<CategoriesModel> get categoriesModel => _categoriesModel;
  static List<CategoriesModel> _categoriesModel = [];

  var colorBack = Colors.white.obs;
  var colorText = Colors.black.obs;

  final CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('Category');
  Future<List<QueryDocumentSnapshot>> getCategories() async {
    var value = await categoriesRef.get();
    return value.docs;
  }

  GetCategories() async {
    _categoriesModel.clear();
    await getCategories().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categoriesModel.add(CategoriesModel.fromJson(value[i].data()));
      }
      update();
    });
  }
}
