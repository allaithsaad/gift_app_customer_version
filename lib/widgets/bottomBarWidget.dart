import 'package:flutter/material.dart';
import '../core/controller/botton_bar_controller.dart';
import 'package:get/get.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

Widget bottomNavigationBar() {
  return GetBuilder<ButtonBarController>(
    init: ButtonBarController(),
    builder: (controller) => BottomNavyBar(
      selectedIndex: controller.navigatorValue,
      onItemSelected: (index) => controller.changeSelectedValue(index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home_outlined),
          title: Text('الرئيسيه'),
          activeColor: Colors.red,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            title: Text('السله'),
            activeColor: Colors.purpleAccent),
        BottomNavyBarItem(
            icon: Icon(Icons.message_outlined),
            title: Text('الرسائل'),
            activeColor: Colors.blue),
        BottomNavyBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('المستخدم'),
            activeColor: Colors.red),
      ],
    ),
  );
}
