import 'package:flutter/material.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RenderRefrigeratorListTitle(),
        RenderListView(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
        ),
      ],
    );
  }
}

/// 식재료 item ListView
class RenderListView extends StatelessWidget {
  const RenderListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RenderRefrigeratorItem(
            label: "식재료명",
            dDay: "D-100",
          );
        },
      ),
    );
  }
}

/// 실제 식재료 item
class RenderRefrigeratorItem extends StatelessWidget {
  String label;
  String dDay;
  RenderRefrigeratorItem({
    super.key,
    required this.label,
    required this.dDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Column(
          children: [
            Text(label),
            Text(
              dDay,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class RenderRefrigeratorListTitle extends StatelessWidget {
  const RenderRefrigeratorListTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            top: 15,
          ),
          child: Text(
            "냉장실",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        Divider(
          thickness: 3.5,
          indent: 8,
          endIndent: 10,
        ),
      ],
    );
  }
}
