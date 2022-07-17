import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class Gifts_catg_home_slider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110.0,

          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, i) {
              return GestureDetector(
                child: Column(
                  children: [

                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                              height: 100,
                              width: 120,
                              child: Image.asset(
                                'assets/images/3.jpg',
                                fit: BoxFit.cover,
                              ),),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Badge(
                                toAnimate: false,
                                shape: BadgeShape.circle,
                                badgeColor: Colors.green,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    topRight: Radius.circular(10)),
                                badgeContent: Text('عدد 5',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                onTap: () {
                  print(123);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
