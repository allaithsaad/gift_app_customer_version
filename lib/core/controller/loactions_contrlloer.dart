import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'Network_Type.dart';

class LocationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Location _location = new Location();
  final geo.GeolocatorPlatform _geolocatorPlatform =
      geo.GeolocatorPlatform.instance;
  geo.Position locationData;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  bool permissionAllowed;
  Future<void> checkServiceEnabled() async {
    //هذه الدالة تقوم بتاكد من أن خدمة تحديد المواقع مفعلة و أن المستخدم قام بالسماح للتطبيق بمعرفة موقعة الحالي
    this.permissionAllowed = false;
    _serviceEnabled = await _location.serviceEnabled();
    if (_serviceEnabled) {
      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        //do what tha app do
        this.permissionAllowed = true;
        update();
      } else {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          //do what tha app do
          this.permissionAllowed = true;
          update();
        } else {
          Get.back();
        }
      }
    } else {
      _serviceEnabled = await _location.requestService();
      if (_serviceEnabled) {
        _permissionGranted = await _location.hasPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          //do what tha app do
          this.permissionAllowed = true;
          update();
        } else {
          _permissionGranted = await _location.requestPermission();
          if (_permissionGranted == PermissionStatus.granted) {
            //do what tha app do
            this.permissionAllowed = true;
            update();
          } else {
            // exiet from the app
            Get.back();
          }
        }
      } else {
        // exiet from the app
        Get.back();
      }
    }
  }

  double latitude = 15.374437778098642;
  double longitude = 44.21145226198674;

  Future<void> getCurrentPosition() async {
    //هذه الدالة تقوم بالحصول على الموقع الحالي للمستخدم
    geo.Position position;
    if (permissionAllowed) {
      position = await _geolocatorPlatform
          .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high)
          .catchError((e) {
        print(e);
      });
    }

    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;

      update();
    } else {
      print('prmission not allowed');
    }
  }

  Rx<LatLng> userPosition = LatLng(0.00, 0.00).obs;
  Rx<LatLng> deliveryPostion = LatLng(0.00, 0.00).obs;
  var deliveryPlaceDiscretion = "".obs;
  var deliveryPlace = "".obs;
  final testConnection = Get.find<NetworkConnecationType>();

  Future<void> addLocation() async {
    testConnection.onInit();

    String deliveryPlaceDiscretionA = this.deliveryPlaceDiscretion.value;
    if (testConnection.connectionType != 0) {
      if (locationLength.value <= 4) {
        print(locationLength);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11");
        try {
          String id = _firestore
              .collection('Users')
              .doc(_auth.currentUser.uid)
              .collection("Locations")
              .doc()
              .id;
          await _firestore
              .collection('Users')
              .doc(_auth.currentUser.uid)
              .collection("Locations")
              .doc(id)
              .set({
            'locationId': id,
            'userId': _auth.currentUser.uid,
            'userPostion': GeoPoint(
                userPosition.value.latitude, userPosition.value.longitude),
            'deliveryPostion': GeoPoint(deliveryPostion.value.latitude,
                deliveryPostion.value.longitude),
            'deliveryPlaceName': "",
            'deliveryPlaceDiscretion': deliveryPlaceDiscretionA,
            'date': DateTime.now(),
          }).then((v) {
            Get.back();
            deliveryPlaceDiscretion.value = "";
          }).catchError((e) {
            Get.snackbar("Error", e.toString());
            Get.back();
            deliveryPlaceDiscretion.value = "";
          });
        } catch (error) {
          Get.snackbar("error", error.message);
        }
      } else {
        Get.snackbar("  إشعار ",
            "لا يمكنك حفظ أكثر من 5 مواقع الرجاء حذف المواقع القديمة لكي يتم إضافة الجديدة ");
      }
    } else {
      Get.snackbar("ERROR", "NO INETRTNET");
    }
  }

  Stream<QuerySnapshot> getLocation() async* {
    final Stream<QuerySnapshot> value = _firestore
        .collection('Users')
        .doc(_auth.currentUser.uid)
        .collection('Locations')
        .orderBy('date')
        .snapshots();

    yield* value;
  }

  RxInt locationLength = 0.obs;
  Future<void> getLocationleng() async {
    try {
      final QuerySnapshot qSnap = await _firestore
          .collection('Users')
          .doc(_auth.currentUser.uid)
          .collection('Locations')
          .get();
      locationLength.value = qSnap.docs.length;
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocationleng();
  }
}
