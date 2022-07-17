import 'package:flutter/material.dart';
import '/widgets/custom%20widgets/categoriesWidget.dart';
import '/widgets/custom%20widgets/product_girdview_widget.dart';

class Categorieds extends StatefulWidget {
  @override
  _CategoriedsState createState() => _CategoriedsState();
}

class _CategoriedsState extends State<Categorieds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' الاقسام'),
          backgroundColor: Colors.deepPurple,
        ),
        body: CategoriesWidget());
  }
}
