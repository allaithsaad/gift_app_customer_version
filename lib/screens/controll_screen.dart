import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/controller/botton_bar_controller.dart';
import '../widgets/bottomBarWidget.dart';

class ControllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonBarController>(
      init: Get.find(),
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}
