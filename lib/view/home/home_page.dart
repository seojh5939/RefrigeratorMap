import 'package:flutter/material.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
import 'package:refrigerator_map/view/common/floating_action_button.dart';
import 'package:refrigerator_map/view/home/home_category_list.dart';
import 'package:refrigerator_map/view/refrigerator/add_refrigerator_page.dart';

/// 메인 페이지
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return HomeCategoryList();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
          title: "식재료 추가",
          onTab: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddRefrigeratorPage(),
              ),
            );
          }),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
