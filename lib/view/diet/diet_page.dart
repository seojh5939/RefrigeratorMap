import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
import 'package:refrigerator_map/view/common/calendar.dart';
import 'package:refrigerator_map/view/common/floating_action_button.dart';
import 'package:refrigerator_map/view/diet/add_diet_page.dart';
import 'package:refrigerator_map/viewModel/diet_viewmodel.dart';

/// 식단표 페이지
class DietPage extends StatelessWidget {
  const DietPage({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> mealTimeList = ["아침", "점심", "저녁", "간식"]; // 식단표 시간 List
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 달력
            CustomCalendar(widgetName: context.widget.toString()),
            SizedBox(height: 15),
            // 1주일 달력
            Container(
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dayButton(context: context),
              ),
            ),
            SizedBox(height: 15),
            // 식단표
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.separated(
                  itemCount: mealTimeList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 8,
                    );
                  },
                  itemBuilder: (context, index) {
                    return mealCard(context, mealTimeList[index]);
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNaviBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingActionButton(
        onTab: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddDietPage(mealTimeList: mealTimeList)),
          );
        },
      ),
    );
  }

  // 시간별 식단표카드(아침, 점심, 저녁, 간식)
  Container mealCard(BuildContext context, String mealTime) {
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.14,
              height: MediaQuery.of(context).size.height * 0.07,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Text(mealTime, style: TextStyle(fontSize: 20)),
            ),
            Spacer(),
            // TODO 식사메뉴 String 받아서 적용.
            Text(
              "삼겹살 구이",
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> dayButton({required BuildContext context}) {
    List<Widget> list = [];
    List<String> dayList = ["일", "월", "화", "수", "목", "금", "토"];
    for (int i = 0; i < 7; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(1.4),
          child: InkWell(
            onTap: () {
              context.read<DietViewModel>().viewSelectedDay(i);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                context.watch<DietViewModel>().isSelectedList[i] == true
                    ? printDayTextWithSelectedCircle(context, dayList[i])
                    : printDayText(context, dayList[i]),
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  // 클릭시 해당 요일 선택표시
  Container printDayTextWithSelectedCircle(BuildContext context, String day) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.125,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.orangeAccent),
      child: printDayText(context, day),
    );
  }

  // 요일만 표시
  SizedBox printDayText(BuildContext context, String day) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.125,
      height: MediaQuery.of(context).size.height * 0.06,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
                color: day == "일" ? Colors.red : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: "30\n",
              ),
              TextSpan(
                text: day,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
