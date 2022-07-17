import 'package:flutter/material.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';




class CatgoNewSlider extends StatelessWidget {
  @override
  List<CardItem> items = [
    IconTitleCardItem(
      text: "زواج",
      iconData: Icons.favorite,
    ),
    IconTitleCardItem(
      text: "تخرج",
      iconData: Icons.grade,
    ),
    IconTitleCardItem(
      text: "عيد ميلاد",
      iconData: Icons.accessibility,
    ),
    IconTitleCardItem(
      text: "قائمة الهدايا",
      iconData: Icons.card_giftcard,
    ),
    IconTitleCardItem(
      text: "قائمة الهدايا",
      iconData: Icons.card_giftcard,
    ),
    IconTitleCardItem(
      text: "قائمة الهدايا",
      iconData: Icons.card_giftcard,
    ),

  ];
  Widget build(BuildContext context) {
    return HorizontalCardPager(initialPage: 2,
    onPageChanged: (page) => print("page : $page"),
    onSelectedItem: (page) => print("selected : $page"),
    items: items,);
  }
}




