import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                "지출 달력",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TableCalendar(
                focusedDay: context.watch<ShoppingViewModel>().focusedDay,
                firstDay: DateTime(2023, 1, 1),
                lastDay: DateTime(9999, 12, 31),
                selectedDayPredicate: (day) {
                  return viewModel.isSameDay(day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!viewModel.isSameDay(selectedDay)) {
                    viewModel.changeday(focusedDay, selectedDay);
                  }
                }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
