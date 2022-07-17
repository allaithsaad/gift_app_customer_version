import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/controller/botton_bar_controller.dart';
import '/core/controller/loactions_contrlloer.dart';
import '/core/controller/phone_auth_controller.dart';
import '/core/controller/userProfileController.dart';
import '/screens/cart_screen.dart';
import '/screens/homeScreen.dart';
import 'auth/RigsiterScreen.dart';
import 'auth/phone_Auth_Screen.dart';
import 'controll_screen.dart';
import 'inner_screens/myAccount.dart';
import 'inner_screens/favorite_screen.dart';
import 'location/locationScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserinfoScreen extends StatefulWidget {
  @override
  _UserinfoScreenState createState() => _UserinfoScreenState();
}

class _UserinfoScreenState extends State<UserinfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
              title: Text('حساب المستخدم'),
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)))),
          body: _auth.currentUser == null ? NonSigned() : SignIn()),
    );
  }
}

class NonSigned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<PhoneAuthContrller>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.assignment_ind,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'يرجا تسجيل الدخول',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
          ),
          TextButton(
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login_rounded,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('تسجيل الدخول'),
                      ])),
            ),
            onPressed: () {
              authController.validPhoneNumber.value = false;
              Get.to(() => PhoneAuthScreen());
            },
          ),
        ],
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationscount = Get.find<LocationController>();
    final controllerx = Get.find<UserProfileController>();
    final bottonController = Get.find<ButtonBarController>();

    locationscount.onInit();
    controllerx.onInit();
    return Center(
      child: Card(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: SafeArea(
                child: Column(
                  children: [
                    Obx(
                      () => userListTile(
                        'حسابي',
                        controllerx.name.value,
                        Icons.person,
                        context,
                        () {
                          controllerx.userSPData.name == null
                              ? Get.to(RigsiterScreen())
                              : Get.to(MyAccount());
                        },
                      ),
                    ),
                    userListTile(
                        'طلباتي', '2 طلبات سابقه', Icons.card_giftcard, context,
                        () {
                      controllerx.userSPData.name == null
                          ? Get.to(RigsiterScreen())
                          : Get.to(() => CartScreen());
                    }),
                    Divider(),
                    Obx(
                      () => userListTile(
                          'عناوين',
                          '${locationscount.locationLength.value} عنوان ',
                          Icons.location_on,
                          context, () {
                        controllerx.userSPData.name == null
                            ? Get.to(RigsiterScreen())
                            : Get.to(LocationsScreen());
                      }),
                    ),
                    Divider(),
                    userListTile('المفضله', '0 منتجات', Icons.favorite, context,
                        () {
                      Get.to(FavoriteScreen());
                    }),
                    Divider(),
                    userListTile('الاشعارات', 'لا يوجد',
                        Icons.notifications_active, context, () {
                      controllerx.userSPData.name == null
                          ? Get.to(RigsiterScreen())
                          : Get.to(MyAccount());
                    }),
                    Divider(),
                  ],
                ),
              ),
            ),
            TextButton(
              child: Text('sign out'),
              onPressed: () async {
                controllerx.signOut();
                controllerx.signOut();
                bottonController.navigatorValue = 0;
                bottonController.currentScreen = Home_Screen();
                Get.offAll(() => ControllScreen());
              },
            )
          ],
        ),
      )),
    );
  }
}

Widget userListTile(String title, String subtitle, IconData iconName,
    BuildContext context, Function pageNam) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: Colors.redAccent,
      child: ListTile(
        onTap: pageNam,
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(
          iconName,
          size: 30,
        ),
      ),
    ),
  );
}
