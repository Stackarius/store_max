import 'package:flutter/material.dart';
import 'package:store_max/contants/colors.dart';
import 'package:store_max/pages/add_edit_product_page.dart';
import 'package:store_max/pages/home_page.dart';

import '../pages/store_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  List pages = [HomePage(), StorePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        onTap:
            (index) => setState(() {
              currentIndex = index;
            }),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.secondary,
        elevation: 2,
        iconSize: 24,
        showUnselectedLabels: false,
        selectedFontSize: 16,
        selectedItemColor: AppColors.primary,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.store), label: "My Store"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.yellow,
        child: Icon(Icons.add, size: 35),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditProductScreen()),
          );
        },
      ),
    );
  }
}
