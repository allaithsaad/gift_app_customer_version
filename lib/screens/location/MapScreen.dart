import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../core/controller/loactions_contrlloer.dart';

import 'LocationDetailsScreen.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final locationc = Get.put(LocationController());

  Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    LatLng currentLocation = LatLng(locationc.latitude, locationc.longitude);
    locationc.userPosition.value = currentLocation;
    locationc.onInit();

    void _onMapCreated(GoogleMapController controller) {
      locationc.deliveryPostion.value = currentLocation;
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('delvryPlace'),
            position: currentLocation,
            infoWindow: InfoWindow(
                title: "مكان التوصل", snippet: "سوف يتم توصيل طلبك الى هناء")));
      });
    }

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     SizedBox(
      //       width: 20,
      //     ),
      //     TextButton(
      //       child: Text('حـفـظ', style: TextStyle(color: Colors.black)),
      //       onPressed: () {
      //         Get.off(LocationDetailsScreen());
      //       },
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentLocation,
                  zoom: 17,
                ),
                onMapCreated: _onMapCreated,
                markers: _markers,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                onTap: _handlTap,
              ),
            ),
            // FloatingActionButton.extended(
            //   onPressed: _currentLocation,
            //   label: Text('My Location'),
            //   icon: Icon(Icons.location_on),
            // ),
            Container(
              height: 80,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.pink[300],
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0))
                  ]),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Obx(() => TextButton(
                          onPressed:
                              locationc.deliveryPlaceDiscretion.value.length > 9
                                  ? () async {
                                      await locationc.addLocation();
                                    }
                                  : () {},
                          child: Text(
                            'حفظ',
                            style: TextStyle(
                                color: locationc.deliveryPlaceDiscretion.value
                                            .length >
                                        9
                                    ? Colors.black
                                    : Colors.blueGrey[300],
                                fontWeight: FontWeight.bold),
                          )))),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      maxLines: 2,
                      onChanged: (value) {
                        locationc.deliveryPlaceDiscretion.value = value;
                      },
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText:
                            "صنعاء -شارع الستين الجنوبي جوار مدرسة الدرة ...",
                        filled: true,
                        fillColor: Colors.pink[300],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.pink[300],
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' إذا لم تكن العلامة في مكانها الصحيح أرجاء الضغط على المكن الصحيح , ثم الضغط على زر الحفظ ',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  _handlTap(LatLng tappedPoint) {
    locationc.deliveryPostion.value = tappedPoint;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('delvryPlace'),
          position: tappedPoint,
          infoWindow: InfoWindow(
              title: "مكان التوصل", snippet: "سوف يتم توصيل طلبك الى هناء"),
        ),
      );
    });
  }
}
