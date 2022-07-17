import 'package:cloud_firestore/cloud_firestore.dart';

class LoactionsModel {
  String deliveryPlaceDiscretion, deliveryPlaceName, userId, locationId;
  DateTime date;
  GeoPoint deliveryPostion;
  LoactionsModel(
      {this.deliveryPlaceDiscretion,
      this.deliveryPlaceName,
      this.userId,
      this.locationId});

  LoactionsModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    deliveryPlaceDiscretion = map['deliveryPlaceDiscretion'];
    deliveryPlaceName = map['deliveryPlaceName'];
    deliveryPostion = map['deliveryPostion'];
    userId = map['userId'];
    locationId = map['locationId'];
    date =
        DateTime.fromMicrosecondsSinceEpoch(map['date'].microsecondsSinceEpoch);
  }

  toJson() {
    return {
      'deliveryPlaceDiscretion': deliveryPlaceDiscretion,
      'deliveryPlaceName': deliveryPlaceName,
      'deliveryPostion': deliveryPostion,
      'userId': userId,
      'locationId': locationId,
      'date': date,
    };
  }
}
