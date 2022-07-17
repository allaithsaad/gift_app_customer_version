import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '/core/controller/loactions_contrlloer.dart';
import '/core/controller/newOrderController.dart';
import 'MapScreen.dart';

class LocationsScreenOrder extends StatefulWidget {
  const LocationsScreenOrder({Key key}) : super(key: key);

  @override
  _LocationsScreenOrderState createState() => _LocationsScreenOrderState();
}

class _LocationsScreenOrderState extends State<LocationsScreenOrder> {
  @override
  Widget build(BuildContext context) {
    final locationc = Get.find<LocationController>();
    final newOrderController = Get.find<NewOrderController>();
    locationc.onInit();
    return Scaffold(
      appBar: AppBar(
        title: Text('المواقع المحفوظة'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_location_alt_outlined,
              size: 30,
            ),
            onPressed: () async {
              await locationc.checkServiceEnabled();
              await locationc.getCurrentPosition();
              if (locationc.permissionAllowed) {
                Get.off(MapScreen());
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
                return Container(
                  width: Get.width,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.redAccent,
                      child: ListTile(
                        onTap: () async {
                          print(
                              "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#####################");
                          print(snapshot.data.docs[index].get('locationId'));
                          await newOrderController
                              .fatchCurrentOrderDelvreyLocation(
                                  snapshot.data.docs[index].get('locationId'));
                        },
                        title: Text(
                          snapshot.data.docs[index].get('deliveryPlaceName'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          snapshot.data.docs[index]
                              .get('deliveryPlaceDiscretion'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Icon(
                          Icons.location_on,
                          size: 30,
                        ),
                        trailing: SizedBox(
                          height: Get.height * 0.9,
                          width: Get.width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete_forever),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .collection('Locations')
                                      .doc(snapshot.data.docs[index]
                                          .get('locationId'))
                                      .delete()
                                      .then((v) => {
                                            Get.snackbar(
                                                "إشعار ", "تم الحذف بنجاح"),
                                          })
                                      .catchError((onError) {
                                    Get.snackbar("error", onError.message);
                                  });
                                },
                              ),
                            ],
                          ),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child:
                    Text("قم ب إضافة الموقع بالضغط على الايقونة في الاعلى "));
          }
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.data.docs[1].exists) {
            return Center(
                child:
                    Text("قم ب إضافة الموقع بالضغط على الايقونة في الاعلى "));
          }
          return Center(
              child: Text("قم ب إضافة الموقع بالضغط على الايقونة في الاعلى "));
        },
      ),
    );
  }
}
