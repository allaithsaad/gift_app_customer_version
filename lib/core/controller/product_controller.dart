import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/service/product_service.dart';
import '../../model/product_model.dart';

class ProductController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);


  static List<ProductModel> get productModel => _productModel;
  static List<ProductModel> _productModel = [];

  static List<ProductModel> get storeProductsModel => _storeProductsModel;
  static List<ProductModel> _storeProductsModel = [];

  static List<ProductModel> get isFaviorte => _isFaviorte;
  static List<ProductModel> _isFaviorte = [];

  static List<ProductModel> get cateModelId => _cateModelId;
  static List<ProductModel> _cateModelId = [];


  ProductController () {
    getProduct();
    getFavorite();
  }

  var catnumber=0.obs;

  void setCatgory(int num){
    _cateModelId.clear();
    catnumber.value=num;
  }


  getProduct() async {
    _loading.value = true;
    await ProductService().getProduct().then((value) {
      for (int i = 0; i < value.length; i++) {
        _productModel.add(ProductModel.fromJson(value[i].data()));
        print(_productModel.length);
        print('____________________________________________________________=');
      }
      _loading.value = false;
      update();
    });
  }

  getStoreProduct(String id) async {
    _loading.value = true;
    _storeProductsModel.clear();
    await ProductService().getStoreProducts(id).then((value) {
      for (int i = 0; i < value.length; i++) {
        _storeProductsModel.add(ProductModel.fromJson(value[i].data()));
      }
      _loading.value = false;
      update();
    });
  }

  getFavorite() async {
    _loading.value = true;
    await ProductService().getFavorit().then((value) {
      for (int i = 0; i < value.length; i++) {
        _isFaviorte.add(ProductModel.fromJson(value[i].data()));
        print(_isFaviorte.length);
        print('____________________________________________________________=');
      }
      _loading.value = false;
      update();
    });
  }

  getCategory() async {
    _loading.value = true;
    _cateModelId.clear();
    await ProductService().getCategories(catnumber.value).then((value) {
      for (int i = 0; i < value.length; i++) {
        _cateModelId.add(ProductModel.fromJson(value[i].data()));
      }
      _loading.value = false;
      print(catnumber.value);
      print('cccccccccccccccccccccccccccccccccccccccccccccccc');
      update();
    });
  }
}