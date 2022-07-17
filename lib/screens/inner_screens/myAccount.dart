import 'package:flutter/material.dart';
import '/screens/controll_screen.dart';
import '../../constance.dart';
import '../../core/controller/Network_Type.dart';

import '../../core/controller/userProfileController.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../User_info_screen.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final UserProfileController controllerx = Get.find();
    final NetworkConnecationType controllerNetwork = Get.find();
    final UserProfileController local = Get.find();
    final nameController = TextEditingController();
    nameController.text = controllerx.userSPData == null
        ? 'no name'
        : controllerx.userSPData.name;
    final phoneNumberController = TextEditingController();
    phoneNumberController.text = controllerx.userSPData == null
        ? 'no phoneNumber'
        : controllerx.userSPData.phoneNumber.replaceAll('+967', '');
    final birthDayController = TextEditingController();
    birthDayController.text = controllerx.userSPData == null
        ? 'no birthDate'
        : controllerx.userSPData.birthDay
            .toString()
            .replaceAll("00:00:00.000", '');
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text('معلومات المستخدم'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            actions: [
              TextButton(
                onPressed: () async {
                  if (controllerNetwork.connectionType != 0) {
                    if (nameController.text.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(_auth.currentUser.uid)
                          .update({
                        'name': nameController.text,
                      }).then((value) async {
                        await local
                            .setSPUser()
                            .then((value) => Get.offAll(ControllScreen()));
                      });
                    } else {
                      Get.snackbar("إشعار", "لايمكنك ترك الاسم فارغ  ");
                    }
                  } else {
                    Get.snackbar("إشعار", "الرجاء التاكد من اتصالك بالانترنت ");
                  }
                },
                child: Text(
                  'حفظ',
                  style: kSendButtonTextStyle,
                ),
              ),
            ],
          ),
          body: GetBuilder<UserProfileController>(
            init: UserProfileController(),
            builder: (controller) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      cursorColor: Colors.deepPurple,
                      controller: nameController,
                      style: TextStyle(color: Colors.deepPurple),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepPurple, width: 1.0),
                        ),
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.deepPurple)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.deepPurple,
                        ),
                        labelText: "الاسـم",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: null,
                      readOnly: true,
                      cursorColor: Colors.deepPurple,
                      textAlign: TextAlign.center,
                      controller: phoneNumberController,
                      style: TextStyle(color: Colors.deepPurple),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepPurple, width: 1.0),
                        ),
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.deepPurple)),
                        labelText: 'الرقم',
                        errorMaxLines: 1,
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      controller: birthDayController,
                      keyboardType: null,
                      style: TextStyle(color: Colors.deepPurple),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepPurple, width: 1.0),
                        ),
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.deepPurple)),
                        labelText: 'تاريخ الميلاد',
                        prefixIcon: const Icon(
                          Icons.date_range,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ToggleSwitch(
                      totalSwitches: 1,
                      minWidth: 90.0,
                      initialLabelIndex: controller.userSPData == null
                          ? 0
                          : controller.userSPData.gender
                              ? 1
                              : 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      icons: controller.userSPData == null
                          ? [FontAwesome.mars]
                          : controller.userSPData.gender
                              ? [FontAwesome.venus]
                              : [FontAwesome.mars],
                      labels: controller.userSPData == null
                          ? [' ذكر ']
                          : controller.userSPData.gender
                              ? [' انثى ']
                              : [' ذكر '],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
