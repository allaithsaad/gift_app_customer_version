import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import '/core/controller/categoriesController.dart';
import 'core/controller/Network_Type.dart';
import 'core/controller/botton_bar_controller.dart';
import 'core/controller/loactions_contrlloer.dart';
import 'core/controller/newOrderController.dart';
import 'core/controller/orderController.dart';
import 'core/controller/phone_auth_controller.dart';
import 'core/controller/homeSliderController.dart';
import 'core/controller/product_controller.dart';
import 'core/controller/store_controller.dart';
import 'core/controller/userProfileController.dart';
import 'screens/inner_screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Questv1'),
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() => {
            Get.put(NetworkConnecationType()),
            Get.put(UserProfileController()),
            Get.put(PhoneAuthContrller()),
            Get.put(ProductController()),
            Get.put(HomeSliderController()),
            Get.put(NewOrderController()),
            Get.put(CategoriesController()),
            Get.put(StoreController()),
            Get.put(ButtonBarController()),
            Get.put(LocationController()),
            Get.put(OrderController()),
          }),
      home: Directionality(
          textDirection: TextDirection.rtl, child: SplashScreen()),
    );
  }
}
