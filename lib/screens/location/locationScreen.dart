import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../core/controller/loactions_contrlloer.dart';
import 'MapScreen.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({Key key}) : super(key: key);

  @override
  _LocationsScreenState createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    final locationc = Get.find<LocationController>();
    locationc.onInit();
    return Scaffold(
      appBar: AppBar(
        title: Text('المواقع المحفوظة'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_location,
              size: 30,
            ),
            onPressed: () async {
              await locationc.checkServiceEnabled();
              await locationc.getCurrentPosition();
              if (locationc.permissionAllowed) {
                Get.to(MapScreen());
                locationc.permissionAllowed = false;
              } else {
                Get.defaultDialog(
                  title: "إِشــعــار",
                  content: Text('الرجاء تفعيل خدمات تحديد المواقع '),
                  barrierDismissible: false,
                  radius: 50.0,
                  confirm: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("مـوافـق")),
                );
              }
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: locationc.getLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data.docs.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  width: Get.width,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.redAccent,
                      child: ListTile(
                        title: Text("عنوان رقم ${index + 1}"),
                        subtitle: Text(snapshot.data.docs[index]
                            .get('deliveryPlaceDiscretion')),
                        leading: Icon(
                          Icons.location_on,
                          size: 30,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_forever),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "إشـعـار",
                              middleText: "هـل تريد حذف هذا الموقع ",
                              backgroundColor: Colors.white,
                              titleStyle: TextStyle(color: Colors.black),
                              middleTextStyle: TextStyle(color: Colors.black),
                              textConfirm: "نـعـم ",
                              textCancel: "لا ",
                              cancelTextColor: Colors.black,
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.red,
                              barrierDismissible: false,
                              radius: 50,
                              onConfirm: () {
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .collection('Locations')
                                    .doc(ds.id)
                                    .delete()
                                    .then((v) => {
                                          Get.snackbar(
                                              "إشعار ", "تم الحذف بنجاح"),
                                          Navigator.pop(context),
                                        })
                                    .catchError((onError) {
                                  Get.snackbar("error", onError.message);
                                });
                                Get.back();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 7,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text("قم ب إضافة الموقع بالضغط على الايقونة في الاعلى ");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
