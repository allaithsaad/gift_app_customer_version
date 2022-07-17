import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import '../../core/controller/phone_auth_controller.dart';

class OptScreen extends StatefulWidget {
  @override
  _OptScreenState createState() => _OptScreenState();
}

class _OptScreenState extends State<OptScreen> {
  final authController = Get.find<PhoneAuthContrller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('شـاشـة التحـقـق'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                    ' إدخل رمز التحـقق المرسل إلى ${authController.phoneNumber.value.replaceAll('+967', '')}\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t  في الفراغ أسفل   '),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      cursorWidth: 0.0,
                      keyboardAppearance: Brightness.light,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      appContext: context,
                      keyboardType: TextInputType.number,
                      length: 6,
                      onChanged: (value) {
                        authController.smsCodeSend.value = value;
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          inactiveColor: Colors.purple,
                          activeFillColor: Colors.orange,
                          selectedColor: Colors.brown),
                      onCompleted: (v) {
                        authController.otpScreenIsLoading.value = true;
                        authController.signInwithPhoneNumber();
                      },
                    ),
                  ),
                ),
                Obx(
                  () => authController.otpScreenIsLoading.value == true ||
                          authController.isResendLoding.value == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SpinKitWave(
                            color: Colors.deepPurple,
                            size: 40,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Container(
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: authController.wait.value == true
                                      ? () {}
                                      : () {
                                          authController.isResendLoding.value =
                                              true;
                                          authController
                                              .verifyResendPhoneNumber();
                                        },
                                  child: Text(
                                    'إعادة إرسال ',
                                    style: TextStyle(
                                        color: authController.wait.value
                                            ? Colors.grey
                                            : Colors.blue),
                                  ),
                                ),
                                Text("  خلال    "),
                                Obx(
                                  () => Text('00:${authController.start.value}',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
/*
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => authController.otpScreenIsLoading.value == true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpinKitWave(
                        color: Colors.deepPurple,
                        size: 40,
                      ),
                    )
                  : FloatingActionButton.extended(
                      elevation: 2,
                      backgroundColor:
                          authController.smsCodeSend.value.length == 6
                              ? Colors.deepPurple
                              : Colors.grey,
                      foregroundColor: Colors.white,
                      onPressed: authController.smsCodeSend.value.length == 6
                          ? () {
                              authController.otpScreenIsLoading.value = true;
                              authController.signInwithPhoneNumber();
                            }
                          : () {},
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '     تأكيد     ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
       */
        ],
      ),
    );
  }
}
