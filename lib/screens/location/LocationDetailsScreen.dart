import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/controller/loactions_contrlloer.dart';

class LocationDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationc = Get.find<LocationController>();
    locationc.onInit();
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "LocationDetailsScreen ",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => TextButton(
              child: Text("حـفـظ "),
              onPressed: locationc.deliveryPlaceDiscretion.value.length > 5 &&
                      locationc.deliveryPlace.value.length > 5
                  ? () async {
                      await locationc.addLocation();
                    }
                  : () {
                      Get.snackbar('إشـعـار', 'تـأكد من ملا الحقول ');
                    },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              textFeild('مــا اســم هـذا الـمكان', 1, ((value) {
                locationc.deliveryPlace.value = value;
              })),
              SizedBox(
                height: 20,
              ),
              textFeild('  قـم بـوصـف مـن مـكـان الـتـوصيـل هـنـا', 4,
                  ((value) {
                locationc.deliveryPlaceDiscretion.value = value;
              })),
              SizedBox(
                height: 20,
              ),
              Text(locationc.deliveryPostion.value.toString()),
              Text(locationc.userPosition.value.toString()),
              SizedBox(
                height: 20,
              ),
              Container(
                height: Get.height * 0.4,
                width: Get.width,
                child: Center(
                  child: GoogleMap(
                    compassEnabled: true,
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                      target: locationc.deliveryPostion.value,
                      zoom: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFeild(String hint, int maxl, Function _onChanged) {
    return TextField(
      onChanged: _onChanged,
      autofocus: false,
      style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
      maxLines: maxl,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }
}
