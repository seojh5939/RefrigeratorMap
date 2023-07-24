import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
import 'package:refrigerator_map/view/common/floating_action_button.dart';
import 'package:refrigerator_map/view/home/home_category_list.dart';
import 'package:refrigerator_map/view/home/add_refrigerator_page.dart';
import 'package:refrigerator_map/viewModel/main_viewmodel.dart';

/// 메인 페이지
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var list = context.read<MainViewModel>().list; // 보관칸 저장 리스트
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return HomeCategoryList(label: list[index]);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddRefrigeratorPage(),
              ),
            ),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
          CustomFloatingActionButton(
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddRefrigeratorPage(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
