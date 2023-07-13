import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/view/common/calendar.dart';
import 'package:refrigerator_map/view/shopping/add_shopping_page.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
import 'package:refrigerator_map/view/common/floating_action_button.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

/// 장보기 페이지
class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    ShoppingViewModel viewModel = context.read<ShoppingViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomCalendar(widgetName: context.widget.toString()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        title: "장보기 추가",
        onTab: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddShoppingPage(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
