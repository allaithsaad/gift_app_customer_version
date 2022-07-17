import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/screens/auth/optScreen.dart';
import '../../core/controller/userProfileController.dart';
import '../../model/user_model.dart';
import '../../screens/auth/RigsiterScreen.dart';
import '../../screens/controll_screen.dart';
import '../../core/service/firestore_user.dart';

class PhoneAuthContrller extends GetxController {
  UserProfileController local = Get.find();
  RxInt fristTmie = 0.obs;
  RxInt start = 30.obs;
  var wait = false.obs;
  var isLoding = false.obs;
  var spenKit = false.obs;
  var phoneNumber = ''.obs;
  var smsCodeSend = ''.obs;
  var validUsername = false.obs;
  var validbirthDay = false.obs;
  var userName = ''.obs;
  Rx<DateTime> birthDay = DateTime.now().obs;
  var userGender = false.obs;
  var userId = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final validPhoneNumber = false.obs;
  final verificationIdFinal = ''.obs;

  bool currentUserStuts() {
    final User user = _auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> verifyPhoneNumber() async {
    isLoding.value = true;
    update();
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      isLoding.value = false;
      update();
      await _auth
          .signInWithCredential(phoneAuthCredential)
          .whenComplete(() async {
        await _firestore
            .collection('Users')
            .doc(_auth.currentUser.uid)
            .get()
            .then((v) async {
          if (v.exists) {
            await local
                .setSPUser()
                .then((value) => Get.offAll(ControllScreen()));
          } else {
            Get.offAll(RigsiterScreen());
          }
        });
        verificationIdFinal.value = "";
        smsCodeSend.value = "";
        phoneNumber.value = "";
      });
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      if (exception.toString() == "firebase_auth/invalid-verification-id") {
        Get.snackbar('إشـعـار', "رقــم التحـقــق خـطـاء ");
      } else if (exception.message.contains('A network error')) {
        Get.snackbar('إشــعار ', "تـأكـد مـن إتـصالـك ب الإنترنت ",
            duration: Duration(seconds: 5));
      } else {
        Get.snackbar('إشـعـار', exception.toString());
        print('_____________________________________________');
        print(exception.toString());
      }
      spenKit.value = false;
      isLoding.value = false;
      isLoding.value = false;
      validPhoneNumber.value = false;
      update();
    };
    PhoneCodeSent codeSentt =
        (String verificationID, [int forceResnedingtoken]) {
      isLoding.value = true;
      isLoding.value = false;
      verificationIdFinal.value = verificationID;
      spenKit.value = false;

      Get.to(() => OptScreen());
      fristTmie.value++;
      startTimer();
      Get.snackbar('إشـعـار', 'تـم إرسـال رمـز التحـقق ');

      update();
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {};
    try {
      await _auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 30),
          phoneNumber: this.phoneNumber.value,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSentt,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      Get.snackbar('إشـعـار', e.toString());

      isLoding.value = false;
      if (e.toString() == 'firebase_auth/network-request-failed') {
        Get.snackbar('إشــعار ', "تـأكـد مـن إتـصالـك ب الإنترنت ",
            duration: Duration(seconds: 3));
      }
    }
    isLoding.value = false;
  }

  var isResendLoding = false.obs;

  Future<void> verifyResendPhoneNumber() async {
    isResendLoding.value = true;
    update();
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      isResendLoding.value = false;
      update();
      await _auth
          .signInWithCredential(phoneAuthCredential)
          .whenComplete(() async {
        await _firestore
            .collection('Users')
            .doc(_auth.currentUser.uid)
            .get()
            .then((v) async {
          if (v.exists) {
            await local
                .setSPUser()
                .then((value) => Get.offAll(ControllScreen()));
          } else {
            Get.offAll(RigsiterScreen());
          }
        });
        verificationIdFinal.value = "";
        smsCodeSend.value = "";
        phoneNumber.value = "";
      });
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      if (exception.toString() == "firebase_auth/invalid-verification-id") {
        Get.snackbar('إشـعـار', "رقــم التحـقــق خـطـاء ");
      } else if (exception.message.contains('A network error')) {
        Get.snackbar('إشــعار ', "تـأكـد مـن إتـصالـك ب الإنترنت ",
            duration: Duration(seconds: 5));
      } else {
        Get.snackbar('إشـعـار', exception.toString());
        print('_____________________________________________');
        print(exception.toString());
      }
      spenKit.value = false;
      isResendLoding.value = false;
      isResendLoding.value = false;
      validPhoneNumber.value = false;
      update();
    };
    PhoneCodeSent codeSentt =
        (String verificationID, [int forceResnedingtoken]) {
      isResendLoding.value = true;
      isResendLoding.value = false;
      verificationIdFinal.value = verificationID;
      spenKit.value = false;

      fristTmie.value++;
      startTimer();
      Get.snackbar('إشـعـار', 'تـم إرسـال رمـز التحـقق ');

      update();
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {};
    try {
      isResendLoding.value = true;
      await _auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 30),
          phoneNumber: this.phoneNumber.value,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSentt,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      Get.snackbar('إشـعـار', e.toString());

      isResendLoding.value = false;
      if (e.toString() == 'firebase_auth/network-request-failed') {
        Get.snackbar('إشــعار ', "تـأكـد مـن إتـصالـك ب الإنترنت ",
            duration: Duration(seconds: 3));
      }
    }
    isResendLoding.value = false;
  }

  void startTimer() async {
    wait.value = true;
    while (start.value != -1) {
      await Future.delayed(Duration(seconds: 1));
      if (start.value == 0) {
        wait.value = false;
        validPhoneNumber.value = false;
        update();
        start.value = 30;
        update();
        break;
      } else {
        start.value--;
      }
    }
  }

  var otpScreenIsLoading = false.obs;
  Future<void> signInwithPhoneNumber() async {
    otpScreenIsLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIdFinal.value,
          smsCode: smsCodeSend.value);
      try {
        await _auth.signInWithCredential(credential);

        await _firestore
            .collection('Users')
            .doc(_auth.currentUser.uid)
            .get()
            .then((v) async {
          if (v.exists) {
            await local.setSPUser().then((value) {
              Get.offAll(ControllScreen());
              smsCodeSend.value = '';
              otpScreenIsLoading.value = false;
            });
          } else {
            Get.offAll(RigsiterScreen());
            smsCodeSend.value = '';
            otpScreenIsLoading.value = false;
          }
        });
      } on PlatformException catch (e) {
        if (e.message.contains(
            'The sms verification code used to create the phone auth credential is invalid')) {
          Get.snackbar("إشعار ", "هـناك خطاء في الرمز ");
        }
        if (e.message.contains('The service is currently unavailable.')) {
          Get.snackbar("إشعار ", "لا يوجد اتصال بالانترنت  ");
        } else if (e.message.contains('The sms code has expired')) {
          Get.snackbar("إشعار ", "القد إنتهاء  الرمز ");
        }
        smsCodeSend.value = '';
        otpScreenIsLoading.value = false;
      }
      verificationIdFinal.value = "";
      smsCodeSend.value = "";
      phoneNumber.value = "";
      otpScreenIsLoading.value = false;
    } catch (e) {
      if (e.toString().contains(
          'The sms verification code used to create the phone auth credential is invalid. Please resend the verification')) {
        Get.snackbar('إشـعـار', "رقــم التحـقــق خـطـاء ");
      } else {
        Get.snackbar('إشـعـار', e.toString());
      }

      print(e.toString());
      isLoding.value = false;
      otpScreenIsLoading.value = false;
    }
  }

  Future<void> createUser() async {
    User currentUser = _auth.currentUser;
    userId.value = currentUser.uid;
    await FireStoreUser()
        .addUserToFireStore(UserModel(
      userId: currentUser.uid,
      phoneNumber: currentUser.phoneNumber,
      name: userName.value,
      birthDay: this.birthDay.value.toString(),
      gender: this.userGender.value,
      verifiedUser: false,
      blacklist: false,
      notes: 'لا يوجد ملاحظة ',
    ))
        .then((value) async {
      await local.setSPUser().then((value) => Get.offAll(ControllScreen()));
    });
  }
}
