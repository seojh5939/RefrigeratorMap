import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

class AddShoppingItem extends StatelessWidget {
  AddShoppingItem({
    required this.index,
    required this.title,
    required this.list,
  });
  int index; // ListView의 index
  String title = "";
  List<Shopping> list = [];

  @override
  Widget build(BuildContext context) {
    list = list.where((shopping) => shopping.title == title).toList();
    return Column(
      children: [
        CheckboxListTile(
          title: Text(list[index].content),
          subtitle: Text(
            "\u{1F4B8} ${list[index].amount}원",
            style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w700,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: list[index].isCompleted,
          onChanged: (value) {
            // viewModel.refreshCheckBox(index, value ?? false);
          },
          activeColor: Colors.green,
          checkColor: Colors.black,
        ),
      ],
    );
  }
}
