import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../core/controller/phone_auth_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PhoneAuthScreen extends GetWidget<PhoneAuthContrller> {
  final authController = Get.find<PhoneAuthContrller>();
  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(
        mask: '### ### ###', filter: {"#": RegExp(r'[0-9]')});
    authController.spenKit.value = false;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "تسجيل الدخول",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.perm_phone_msg,
                          size: 50,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextField(
                          inputFormatters: [maskFormatter],
                          buildCounter: (BuildContext context,
                                  {int currentLength,
                                  int maxLength,
                                  bool isFocused}) =>
                              null,
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          textAlign: TextAlign.center,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixText: "   +967",
                            hintText: "   إدخل رقم هاتفك ",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.purple[300],
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                color: Colors.purple,
                                width: 4.0,
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                          showCursor: true,
                          cursorColor: Colors.deepPurple,
                          onChanged: (value) {
                            if (value.length == 11) {
                              if (value.startsWith('70')) {
                                authController.validPhoneNumber.value = true;
                                authController.phoneNumber.value =
                                    "+967${value.removeAllWhitespace}";
                              }
                              if (value.startsWith('71')) {
                                authController.validPhoneNumber.value = true;
                                authController.phoneNumber.value =
                                    "+967${value.removeAllWhitespace}";
                              }
                              if (value.startsWith('73')) {
                                authController.validPhoneNumber.value = true;
                                authController.phoneNumber.value =
                                    "+967${value.removeAllWhitespace}";
                              }
                              if (value.startsWith('77')) {
                                authController.validPhoneNumber.value = true;
                                authController.phoneNumber.value =
                                    "+967${value.removeAllWhitespace}";
                              }
                              if (value == '777 777 777') {
                                authController.validPhoneNumber.value = false;
                              }
                              if (value == '711 111 211') {
                                authController.validPhoneNumber.value = false;
                              }
                            } else {
                              authController.validPhoneNumber.value = false;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text('أدخل الرقــم ثـم إضـغــط على إرســـل '),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Obx(
                  () => authController.spenKit.value == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SpinKitWave(
                            color: Colors.deepPurple,
                            size: 50,
                          ),
                        )
                      : Container(
                          width: Get.width,
                          child: FloatingActionButton.extended(
                            elevation: 2,
                            backgroundColor:
                                authController.validPhoneNumber.value == true &&
                                        authController.isLoding.value != true &&
                                        authController.wait.value != true
                                    ? Colors.deepPurple
                                    : Colors.grey,
                            foregroundColor: Colors.white,
                            onPressed: authController.isLoding.value != true &&
                                    authController.validPhoneNumber.value ==
                                        true &&
                                    authController.wait.value != true
                                ? () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    authController.spenKit.value = true;
                                    authController.verifyPhoneNumber();
                                  }
                                : () {},
                            label: Text(
                              'إرسال',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
