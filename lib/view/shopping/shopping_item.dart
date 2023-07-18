import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/style/color.dart';
import 'package:refrigerator_map/util/global_variable.dart';
import 'package:refrigerator_map/util/preference_keys.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

/// 장보기 item
class ShoppingItem extends StatefulWidget {
  ShoppingItem({
    required this.isSelected,
  });
  // 선택된 토글버튼 확인용
  List<bool> isSelected;
  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    ShoppingViewModel viewModel = context.read<ShoppingViewModel>();
    List<Shopping> shoppingList = viewModel.shoppingList;
    List<Shopping> sortedList = [];

    deepCopyShoppingList(shoppingList, sortedList);

    return sortedList.isEmpty
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 1,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${sortedList[index].title} ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' ${sortedList[index].dttm}\n',
                            style: TextStyle(
                              color: ColorList.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '지출\u{1F4B8}: ${addAmount(sortedList)}원',
                            style: TextStyle(
                              color: Colors.yellow[800],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      iconSize: 20,
                      color: Colors.orangeAccent,
                      onPressed: () {},
                      icon: Icon(Icons.edit_square),
                    ),
                  ],
                ),
                children: generateCheckBoxs(shoppingList, context),
              );
            },
          );
  }

  deepCopyShoppingList(List<Shopping> shoppingList, List<Shopping> sortedList) {
    if (shoppingList.isNotEmpty && shoppingList.length >= 2) {
      for (int i = 0; i < shoppingList.length; i++) {
        if (shoppingList[i].title == shoppingList[i + 1].title) {
          sortedList.addAll([sortedList[i], sortedList[i + 1]]);
        }
      }
    } else {
      sortedList.addAll(shoppingList);
    }
  }

  List<Widget> generateCheckBoxs(List<Shopping> data, BuildContext context) {
    if (data.isEmpty) return [];
    List<Widget> widgetList = [];
    for (int i = 0; i < data.length; i++) {
      widgetList.add(
        CheckboxListTile(
          title: Text(data[i].content),
          secondary: Text("\u{1F4B8} ${data[i].amount}원",
              style: TextStyle(fontSize: 15)),
          controlAffinity: ListTileControlAffinity.leading,
          value: data[i].isCompleted,
          onChanged: (value) {
            context
                .read<ShoppingViewModel>()
                .refreshCheckBox(i, value ?? false);
          },
          activeColor: Colors.green,
          checkColor: Colors.black,
        ),
      );
    }
    return widgetList;
  }

  int addAmount(List<Shopping> data) {
    if (data.isEmpty) return 0;
    int sum = 0;
    data.forEach((element) {
      sum += element.amount;
    });
    return sum;
  }
}
