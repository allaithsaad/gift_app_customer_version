import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '/widgets/custom%20widgets/gifts_catg_home_slider.dart';
import '/widgets/custom%20widgets/icon_button_home.dart';
import '/widgets/custom%20widgets/product_girdview_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Wrap(
              children: [
                Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Wrap(
                      children: [
                        Text(''),
                        Icon_butoon_home(),
                        Divider(),
                        ExpandableNotifier(
                          child: Wrap(
                            children: [
                              ScrollOnExpand(
                                  scrollOnExpand: true,
                                  scrollOnCollapse: true,
                                  child: ExpandablePanel(
                                    theme: const ExpandableThemeData(
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      tapBodyToCollapse: true,
                                    ),
                                    header: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.card_giftcard),
                                        Text(
                                          'اقسام الهدايا',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    expanded: Card(
                                        elevation: 0,
                                        child: Gifts_catg_home_slider()),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 200,
                ),
                ProductWidget(),
              ],
            ),
          )),
    );
  }
}
