import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/view/common/calendar.dart';
import 'package:refrigerator_map/viewModel/diet_viewmodel.dart';
import 'dart:developer' as developer;

/// 식단표 페이지
class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CustomCalendar(widgetName: context.widget.toString()),
          SizedBox(height: 30),
          Container(
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dayButton(context: context),
            ),
          ),
        ],
      ),
    ));
  }

  List<Widget> dayButton({required BuildContext context}) {
    List<Widget> list = [];
    for (int i = 0; i < 7; i++) {
      list.add(dayComponent(context, i));
    }
    return list;
  }

  Widget dayComponent(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(1.4),
      child: InkWell(
        onTap: () {
          context.read<DietViewModel>().viewSelectedDay(index);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            context.watch<DietViewModel>().isSelectedList[index] == true
                ? printDayTextWithSelectedCircle(context)
                : printDayText(context),
          ],
        ),
      ),
    );
  }

  Container printDayTextWithSelectedCircle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.125,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.orangeAccent),
      child: printDayText(context),
    );
  }

  SizedBox printDayText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.125,
      height: MediaQuery.of(context).size.height * 0.06,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
                color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: "30\n",
              ),
              TextSpan(
                text: "일",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
