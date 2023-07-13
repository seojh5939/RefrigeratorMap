import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/style/color.dart';
import 'package:refrigerator_map/view/diet/diet_page.dart';
import 'package:refrigerator_map/view/home/home_page.dart';
import 'package:refrigerator_map/view/shopping/shopping_page.dart';
import 'package:refrigerator_map/viewModel/bottom_navi_view_model.dart';

class BottomNaviBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BottomNaviViewModel viewModel = context.read<BottomNaviViewModel>();
    return BottomNavigationBar(
      selectedItemColor: ColorList.black,
      currentIndex: context.watch<BottomNaviViewModel>().bottomIdx,
      onTap: (index) {
        viewModel.changeItem(index);
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ShoppingPage()),
            );
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DietPage()),
            );
          default:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
        }
      },
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
