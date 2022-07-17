import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import '/core/controller/Network_Type.dart';
import '/core/controller/newOrderController.dart';
import '/screens/location/locationScreenFromOrder.dart';

class OrderScreen extends StatelessWidget {
  final String productName;
  final String image;
  final int price;
  final int productId;
  final String storeId;
  OrderScreen(
      this.productName, this.image, this.price, this.productId, this.storeId);
  final newOrderController = Get.find<NewOrderController>();
  @override
  Widget build(BuildContext context) {
    final testConnection = Get.find<NetworkConnecationType>();
    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات المستلم'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                newOrderController.deleteData();
                Get.back();
              },
              icon: Icon(Icons.delete_forever_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Obx(
                  () => ListTails(
                      'موقع التوصيل',
                      newOrderController.orderDelvreyLocationDiscrbtion.value,
                      'تغيير',
                      Icons.location_on, () {
                    Get.to(() => LocationsScreenOrder());
                  }),
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
                                header: ListTile(
                                  title: Text('اضافه ملاحظه'),
                                  leading: Icon(
                                    Icons.note_add,
                                    color: Colors.deepPurple,
                                  ),
                                  subtitle: Obx(() => newOrderController
                                              .noteExixt.value.length >
                                          0
                                      ? Text('')
                                      : Text('لايوجد ملاحظات ')),
                                ),
                                controller: ExpandableController(
                                    initialExpanded: false),
                                expanded: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    textInputAction: TextInputAction.go,
                                    maxLines: 3,
                                    keyboardType: null,
                                    onChanged: (c) {
                                      newOrderController.noteExixt.value = c;
                                    },
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'اكتب ملاحظاتك هنا',
                                    ),
                                    showCursor: true,
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => ListTails(
                      'موعد التسليم',
                      newOrderController.dateOfDelivry.value,
                      'حدد',
                      Icons.calendar_today_sharp, () {
                    showDailog2(context);
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                PriceCard(productName, image, productId, price, storeId),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Obx(() =>
          newOrderController.dateOfDelivry.value != 'لا يوجد تاريخ' &&
                  newOrderController.orderDelvreyLocationDiscrbtion.value !=
                      'لايوجود موقع توصيل' &&
                  testConnection.connectionType != 0
              ? OrderButtons()
              : Text('')),
    );
  }
}

class ListTails extends StatelessWidget {
  final String titles;
  final String subTitles;
  final String buttonName;
  final IconData iconName;
  Function onTapReq;
  ListTails(this.titles, this.subTitles, this.buttonName, this.iconName,
      this.onTapReq);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(titles),
        leading: Icon(
          iconName,
          color: Colors.deepPurple,
        ),
        subtitle: Text(subTitles),
        onTap: onTapReq,
        trailing: TextButton(
          child: Text(buttonName),
          onPressed: () {},
        ),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  var productName, image, productId, price, storeId;

  PriceCard(
      this.productName, this.image, this.productId, this.price, this.storeId);
  @override
  Widget build(BuildContext context) {
    final newOrderController = Get.find<NewOrderController>();
    return Card(
      child: Column(
        children: [
          Text('الفاتوره'),
          Card(
              color: Colors.deepPurple[50],
              child: Column(
                children: [
                  Row(
                    children: [
                      Card(
                        margin: EdgeInsets.all(0),
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              image,
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productId.toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              productName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )),
          Card(
            color: Colors.deepPurple[50],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('المنتج'),
                      Text(price.toString()),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('التوصيل'),
                      Obx(() =>
                          Text(newOrderController.delivryPriceName.value)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الاجمالي',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Obx(
                  () => Text(
                    '${newOrderController.delivryPrice.value + price}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newOrderController = Get.find<NewOrderController>();
    return SizedBox(
      height: 80,
      child: Card(
          color: Colors.white,
          elevation: 10,
          borderOnForeground: true,
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.extended(
                      heroTag: 'buy',
                      hoverColor: Colors.green,
                      elevation: 1,
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        await newOrderController
                            .addNewOrder(newOrderController.setOrderModel());
                      },
                      icon: Icon(Icons.check_circle),
                      label: Text(
                        'تنفيذ الطلب',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 50,
                    )),
                new Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FloatingActionButton.extended(
                      heroTag: 'cart',
                      hoverColor: Colors.grey,
                      elevation: 1,
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.edit),
                      label: Text('تعديل'),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

showDailog2(BuildContext context) {
  final newOrderController = Get.find<NewOrderController>();
  return Get.defaultDialog(
      title: "حدد موعد تسليم الهديه",
      confirm: ElevatedButton(
          onPressed: () {
            if (newOrderController.delivryHour.value !=
                    TimeOfDay(hour: 00, minute: 00) &&
                newOrderController.delivryDay.value != DateTime(1999, 9, 9)) {
              newOrderController.dateOfDelivry.value =
                  'يوم ${newOrderController.delivryDayName.value}الساعة ${newOrderController.delivryHourName.value}';
            } else {
              newOrderController.delivryHour.value =
                  TimeOfDay(hour: 00, minute: 00);
              newOrderController.delivryDay.value = DateTime(1999, 9, 9);
              newOrderController.delivryHourName.value = 'لايوجد وقت';
              newOrderController.delivryDayName.value = 'لايوجد تاريخ';
              Get.snackbar("إشعار", "لم يتم إضافة الوقت ");
            }
            Get.back();
          },
          child: Text("مـوافـق")),
      radius: 5,
      barrierDismissible: true,
      onConfirm: () {},
      content: Column(
        children: [
          Card(
            color: Colors.grey[100],
            child: Row(
              children: [
                Icon(Icons.calendar_today_sharp),
                TextButton(
                  child: Row(
                    children: [
                      Text(' تاريخ التسيلم'),
                      SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Obx(() => Text(
                            newOrderController.delivryDayName.value.toString(),
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime.now().add(Duration(days: 4)),
                        onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                      newOrderController.delivryDay.value =
                          DateTime(date.year, date.month, date.day);
                      newOrderController.delivryDayName.value =
                          DateTime(date.year, date.month, date.day)
                              .toString()
                              .replaceAll("00:00:00.000", '');
                    }, currentTime: DateTime.now(), locale: LocaleType.ar);
                  },
                ),
              ],
            ),
          ),
          Card(
            color: Colors.grey[100],
            child: Row(
              children: [
                Icon(Icons.watch_later),
                TextButton(
                  child: Row(
                    children: [
                      Text('وقت التسليم'),
                      SizedBox(
                        width: 12,
                      ),
                      Obx(() => Text(
                          newOrderController.delivryHourName.value.toString(),
                          style: TextStyle(color: Colors.black)))
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        maxHour: 21.0,
                        blurredBackground: true,
                        is24HrFormat: true,
                        disableMinute: true,
                        minHour: 9.0,
                        context: context,
                        value: TimeOfDay(hour: 9, minute: 00),
                        onChange: (TimeOfDay hamood) {
                          newOrderController.delivryHour.value = hamood;
                          newOrderController.delivryHourName.value =
                              hamood.format(context);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ));
}
