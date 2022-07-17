import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel_home extends StatefulWidget {
  @override
  _Carousel_homeState createState() => _Carousel_homeState();
}

class _Carousel_homeState extends State<Carousel_home> {
  int activeIndex = 0;
  @override
  void initState() {
    getImageSlider();
    super.initState();
  }

  Future getImageSlider() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _fireStore.collection('slideshow').get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImageSlider(),
      builder: (_, snapshot) {
        return snapshot.data == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          DocumentSnapshot sliderImage = snapshot.data[index];
                          Map getImage = sliderImage.data();
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl: getImage['imageUrl'],
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          initialPage: 0,
                          scrollDirection: Axis.vertical,
                          autoPlay: true,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          pauseAutoPlayOnTouch: true,
                          height: 180,
                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index),
                          pauseAutoPlayOnManualNavigate: true,
                          aspectRatio: 0.5 / 1,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: snapshot.data == null
                          ? Container()
                          : AnimatedSmoothIndicator(
                              activeIndex: activeIndex,
                              count: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              effect: WormEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  strokeWidth: 10,
                                  activeDotColor: Colors.red,
                                  dotColor: Colors.black12),
                            ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
