import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laithapp/screens/inner_screens/design_screen.dart';
import '/screens/inner_screens/categoriesScreen.dart';
import '/screens/inner_screens/favorite_screen.dart';
import '/screens/inner_screens/stores_screen.dart';

class Icon_butoon_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icons_widget(Icons.design_services_outlined, DesignScreen(), 'صمم'),
          Icons_widget(Icons.category, Categorieds(), 'الاقسام'),
          Icons_widget(Icons.favorite_border, FavoriteScreen(), 'المفضله'),
          Icons_widget(Icons.storefront_outlined, StoresScreens(), 'المتاجر'),
        ],
      ),
    );
  }
}

class Icons_widget extends StatelessWidget {
  final IconData iconNmae;
  final String iconText;
  final Widget pageName;
  Icons_widget(this.iconNmae, this.pageName, this.iconText);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.grey[100],
                      shape: CircleBorder(),
                    ),
                    child: new IconButton(
                        iconSize: 15,
                        highlightColor: Colors.pinkAccent[100],
                        splashRadius: 22,
                        icon: Icon(iconNmae),
                        color: Colors.black87,
                        onPressed: () => Get.to(() => pageName))),
              ),
              Text(
                iconText,
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
