import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import '/core/controller/product_controller.dart';
import 'categories_gridview.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget>
    with SingleTickerProviderStateMixin {
  var _context;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'تخرج',
      icon: Icon(Icons.card_giftcard),
    ),
    Tab(
      text: 'زواج',
      icon: Icon(FontAwesome.gift),
    ),
    Tab(
      text: 'عيد ميلاد',
      icon: Icon(FontAwesome.smile_o),
    ),
    Tab(
      text: 'خطوبه',
      icon: Icon(FontAwesome.gamepad),
    ),
    Tab(
      text: 'ورد',
      icon: Icon(FontAwesome.shopping_bag),
    ),
  ];

  TabController _tabController;
  @override
  void initState() {
    final gsm = Get.find<ProductController>();
    super.initState();
    _tabController = TabController(
      length: myTabs.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      final newCard = Get.find<ProductController>();
      newCard.setCatgory(_tabController.index);
      print('my index is' + _tabController.index.toString());
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ButtonsTabBar(
                controller: _tabController,
                backgroundColor: Colors.deepPurple,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: myTabs),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                String label = tab.text;
                return SingleChildScrollView(
                    child: CategoriesGridWidget(label));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
