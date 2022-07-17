import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../core/controller/phone_auth_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RigsiterScreen extends StatelessWidget {
  final authController = Get.put(PhoneAuthContrller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "شاشة التسجيل ",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                textField(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: Get.width,
                    child: TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1970, 1, 1),
                            maxTime: DateTime(2015, 1, 1), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          DateTime dateTme = DateTime(2020, DateTime.june, 6);
                          authController.birthDay.value = date;
                          if (date != null) {
                            if (date
                                .isBefore(DateTime(2020, DateTime.june, 6))) {
                              authController.validbirthDay.value = true;
                            }
                          }
                        }, currentTime: DateTime.now(), locale: LocaleType.ar);
                      },
                      child: Text(
                        'إضـغـط علـى الزر ل إضافة تاريخ ميلادك  ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.blue)))),
                    ),
                  ),
                ),
                Divider(),
                toggleSwitch(),
                SizedBox(
                  height: 20,
                ),
                Obx(() => textButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: Get.width,
        child: TextButton(
            child: Text(
              "حــفـــظ",
              style: TextStyle(fontSize: 15),
            ),
            onPressed: authController.validUsername.value == true &&
                    authController.validbirthDay.value == true
                ? () {
                    try {
                      authController.createUser();
                    } catch (error) {
                      Get.snackbar('إشـعـار', error.toString());
                    }
                    Get.defaultDialog(
                      title: "إِشــعــار",
                      content: Text('تــم اضـافت الـمـسـتـخـدم بـنـجـاح '),
                      barrierDismissible: false,
                      radius: 50.0,
                      confirm: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("مـوافـق")),
                    );
                    authController.birthDay.value = null;
                    authController.validbirthDay.value = false;
                    authController.validUsername.value = false;
                  }
                : () {
                    Get.defaultDialog(
                      title: "إِشــعــار",
                      content: Text('الـرجــاء التأكد  مــن ملى الحقول '),
                      barrierDismissible: false,
                      radius: 50.0,
                      confirm: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("مـوافـق")),
                    );
                    print(
                        '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                    print(authController.userName);
                    print(authController.validUsername);
                    print(authController.validbirthDay);
                    print(authController.birthDay);
                    print(
                        '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                  },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue),
                ),
              ),
            )
            /*
             ElevatedButton.styleFrom(
            onPrimary: Colors.black87,
            primary: authController.validUsername.value == true &&
                    authController.validbirthDay.value == true
                ? Colors.grey[300]
                : Colors.grey,
            minimumSize: authController.validUsername.value == true &&
                    authController.validbirthDay.value == true
                ? Size(120, 36)
                : Size(80, 36),
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          */
            ),
      ),
    );
  }

  Widget textField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        keyboardType: TextInputType.name,
        textAlign: TextAlign.center,
        buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
        maxLength: 30,
        onChanged: ((value) {
          if (value.isNotEmpty && value != null && value.length > 6) {
            authController.userName.value = value;
            authController.validUsername.value = true;
          }
        }),
        decoration: InputDecoration(
          hintText: 'إضــف إســمــك هنا ',
          hintStyle: TextStyle(color: Colors.black, fontSize: 13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 4.0,
            ),
          ),
        ),
        style: TextStyle(fontSize: 13),
      ),
    );
  }

  Widget toggleSwitch() {
    return ToggleSwitch(
      totalSwitches: 2,
      minWidth: 160,
      initialLabelIndex: 0,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
      labels: ['ذكر', 'انثى'],
      onToggle: (index) {
        if (index == 1) {
          authController.userGender.value = true;
        }
        if (index == 0) {
          authController.userGender.value = false;
        }
        print('switched to: $index');
        print('___________________');
      },
    );
  }
}
