import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/controller/homeSliderController.dart';
import 'package:page_transition/page_transition.dart';

import '../controll_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeRef = Get.find<HomeSliderController>();
    homeRef.getService();
    return Scaffold(
        body: AnimatedSplashScreen(
            duration: 1000,
            splashIconSize: 150,
            splash: Column(
              children: [
                Icon(
                  Icons.card_giftcard,
                  size: 70,
                  color: Colors.deepPurple,
                ),
                Text(
                  'بوكيه',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                )
              ],
            ),
            nextScreen: ControllScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white));
  }
}
