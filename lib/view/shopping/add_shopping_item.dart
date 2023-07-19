import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/checklist.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

class AddShoppingItem extends StatelessWidget {
  AddShoppingItem({required this.list, required this.index});
  int index;
  List<CheckList> list;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ShoppingViewModel>();
    return Column(
      children: [
        CheckboxListTile(
          title: Text(list[index].content),
          secondary: Text(
            "\u{1F4B8} ${list[index].amount}원",
            style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w700,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: list[index].ischeck,
          onChanged: (value) {
            viewModel.refreshCheckBox(changeValue: value, id: list[index].id!);
          },
          activeColor: Colors.green,
          checkColor: Colors.black,
        ),
      ],
    );
  }
}
