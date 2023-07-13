import 'package:flutter/material.dart';
import 'package:refrigerator_map/view/home/home_category_list.dart';

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
      floatingActionButton: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Colors.black87,
          ),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "식재료 추가",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
