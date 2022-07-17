import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';


class OrderMainScreen extends StatefulWidget {
  final String productName;
  final String orderId;
  final String Date;
  final String loaction;
  final String productPrice;
  final String dliveryPrice;
  final String total;
  final String productImage;
 const OrderMainScreen(this.productName,this.orderId,this.Date,this.loaction,this.productPrice,this.dliveryPrice,this.total,this.productImage);
  @override
  _OrderMainScreenState createState() => _OrderMainScreenState();
}
class _OrderMainScreenState extends State<OrderMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التفاصيل'),
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                 widget.productImage,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('المنتج',
                                      style: TextStyle(fontSize: 15,color: Colors.grey),
                                    ),
                                    SizedBox(width: 20,),
                                    Text(
                                        widget.productName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      ' رقم الطلب',
                                      style: TextStyle(fontSize: 15,color: Colors.grey),
                                    ),
                                    SizedBox(width: 20,),
                                    Text(
                                      widget.orderId,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(
                          height:5,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.date_range),
                              SizedBox(width: 20),
                              Text(widget.Date,style: TextStyle(fontSize: 17),),
                            ],
                          ),
                        ),
                        Divider(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.location_on),
                              SizedBox(width: 20),
                              Text(widget.loaction),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ExpandableNotifier(
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
                                tapBodyToExpand: true,
                              ),
                              header: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(' حاله الطلب',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              controller: ExpandableController(initialExpanded: true ),
                              expanded: Example8Vertical(),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: [
                      Text('الفاتوره ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(' المنتج'),
                                    Text(widget.productPrice),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(' التوصيل'),
                                    Text(widget.dliveryPrice),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(' الاجمالي',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Text(
                              widget.total,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Example8Vertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TimelineTile(
          lineXY: 0.3,
          alignment: TimelineAlign.start,
          isFirst: true,
          indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              drawGap: true,
              indicator: Icon(
                Icons.verified,
                size: 30,
                color: Colors.green,
              )),
          endChild: ChildText(
            text: "تم التاكيد",
            color: Colors.green,
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.start,
          indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              drawGap: true,
              indicator: Icon(
                Icons.watch_later,
                size: 30,
                color: Colors.green,
              )),
          endChild: ChildText(
            text: 'قيد التحضير',
            color: Colors.green,
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.start,
          indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              drawGap: true,
              indicator: Icon(
                Icons.drive_eta_rounded,
                size: 30,
                color: Colors.grey,
              )),
          endChild: ChildText(
            text: 'جاري التوصيل',
            color: Colors.grey,
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.start,
          isLast: true,
          indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              drawGap: true,
              indicator: Icon(
                Icons.check_circle,
                size: 30,
                color: Colors.grey,
              )),
          endChild: ChildText(
            text: 'تم التوصيل',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class ChildText extends StatelessWidget {
  final String text;
  final Color color;
  ChildText({
    key,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 30,height: 40,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(text,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: color, fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
