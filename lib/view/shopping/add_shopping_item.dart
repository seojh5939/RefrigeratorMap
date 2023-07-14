import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

class AddShoppingItem extends StatelessWidget {
  AddShoppingItem({required this.index});
  int index; // ListView의 index

  @override
  Widget build(BuildContext context) {
    ShoppingViewModel viewModel = context.read<ShoppingViewModel>();
    List<Shopping> shoppingList = viewModel.shoppingList;
    return Column(
      children: [
        CheckboxListTile(
          title: Text(shoppingList[index].content),
          subtitle: Text(
            "\u{1F4B8} ${shoppingList[index].amount}원",
            style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w700,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: shoppingList[index].isCompleted,
          onChanged: (value) {
            viewModel.refreshCheckBox(index, value ?? false);
          },
          activeColor: Colors.green,
          checkColor: Colors.black,
        ),
      ],
    );
  }
}
