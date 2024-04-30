import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/collection_page.dart';
import '../pages/search_page.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  List<Widget> pages = <Widget>[
    const SearchPage(),
    const CollectionPage(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
