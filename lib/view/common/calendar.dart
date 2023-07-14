import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/util/global_variable.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

/// 장보기 & 식단표에서 사용하는 달력
class CustomCalendar extends StatelessWidget {
  CustomCalendar({
    required this.widgetName,
  }) {
    viewModel = widgetName == "ShoppingPage"
        ? GlobalAccessContext.navigatorState.currentContext!
            .read<ShoppingViewModel>()
        : "";
    focusedDay = widgetName == "ShoppingPage"
        ? GlobalAccessContext.navigatorState.currentContext!
            .watch<ShoppingViewModel>()
            .focusedDay
        : "";
  }

  String widgetName;
  dynamic viewModel;
  dynamic focusedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      focusedDay: focusedDay,
      firstDay: DateTime(2023, 1, 1),
      lastDay: DateTime(9999, 12, 31),
      locale: 'ko-KR',
      selectedDayPredicate: (day) {
        return viewModel.isSameDay(day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!viewModel.isSameDay(selectedDay)) {
          viewModel.changeday(focusedDay, selectedDay);
        }
      },
    );
  }
}
