import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/controller/userProfileController.dart';
import '../../screens/homeScreen.dart';
import '../../screens/User_info_screen.dart';
import '../../screens/cart_screen.dart';

import '../../screens/support_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ButtonBarController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  inStart2() async {
    if (_auth.currentUser != null) {
      final local = Get.find<UserProfileController>();
      await local.setSPUser().then((value) => local.onInit());
    }
  }

  int navigatorValue = 0;



  Widget currentScreen = Home_Screen();

  void changeSelectedValue(int selectedValue) {
    if (_auth.currentUser != null) {
      final local = Get.find<UserProfileController>();
      local.onInit();
    }
    navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          currentScreen = Home_Screen();
          break;
        }
      case 1:
        {
          currentScreen = CartScreen();
          break;
        }
      case 2:
        {
          currentScreen = SupportScreen();
          break;
        }
      case 3:
        {
          currentScreen = UserinfoScreen();
          break;
        }
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    inStart2();
  }
}
