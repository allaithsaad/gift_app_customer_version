import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../constance.dart';
import '../../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {
  RxString name = ''.obs;
  UserModel get userSPData => _userSPData;
  UserModel _userSPData;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentUserSPData();
    getUserName();
  }

  Future<void> getCurrentUserSPData() async {
    _userSPData = await getSPUser;

    update();
  }

   signOut() async {
    FirebaseAuth.instance.signOut();
    deleteSPUser();
  }

  Future<DocumentSnapshot> _getCurrentUser() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser.uid)
        .get();
  }

  getUserName() async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        if (value != null) {
          name.value = value.get('name');
        } else {
          name.value = "no Name";
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> get getSPUser async {
    try {
      UserModel userModel = await _getUserData();
      if (userModel == null) {
        return null;
      }
      return userModel;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserModel> _getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString(CACHED_USER_DATA);
    return UserModel.fromJson(json.decode(value));
  }

  Future<void> setSPUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await _getCurrentUser().then((value) async {
      await pref.setString(
          CACHED_USER_DATA, json.encode(UserModel.fromJson(value.data())));
    });
  }

  void deleteSPUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
