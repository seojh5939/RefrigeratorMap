import 'package:flutter/material.dart';
import 'package:refrigerator_map/style/color.dart';

class BottomNaviBar extends StatelessWidget {
  const BottomNaviBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: ColorList.black,
      currentIndex: 0,
      onTap: (_) {},
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store_outlined), label: "장보기"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined), label: "식재료"),
      ],
    );
  }
}
