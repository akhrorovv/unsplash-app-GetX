import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: homeController.pages.elementAt(homeController.selectedIndex),
          ),
          bottomNavigationBar: CupertinoTabBar(
            height: 70,
            currentIndex: homeController.selectedIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Iconsax.home)),
              BottomNavigationBarItem(icon: Icon(Iconsax.category_2)),
            ],
            onTap: homeController.onItemTapped,
          ),
        );
      },
    );
  }
}
