import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/style/color.dart';
import 'package:refrigerator_map/view/common/calendar.dart';
import 'package:refrigerator_map/view/shopping/add_shopping_page.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
import 'package:refrigerator_map/view/common/floating_action_button.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

/// 장보기 페이지
class ShoppingPage extends StatefulWidget {
  ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List<bool> isSelected = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    ShoppingViewModel viewModel = context.read<ShoppingViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomCalendar(widgetName: context.widget.toString()),
              ToggleButtons(
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                selectedBorderColor: Colors.red[700],
                fillColor: Colors.black,
                isSelected: isSelected,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "장보기 목록",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "장보기 완료",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
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
