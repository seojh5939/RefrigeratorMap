import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/checklist.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/style/color.dart';
import 'package:refrigerator_map/util/global_variable.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';
import 'dart:developer' as developer;

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

    return FutureBuilder(
      future: _getAllShoppingLists(viewModel),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Error : ${snapshot.error}",
              style: TextStyle(fontSize: 15),
            ),
          );
        } else {
          List<Shopping> shoppingList = snapshot.data;
          // 장보기 item
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: shoppingList.length,
            itemBuilder: (context, index) {
              int selected = 0;
              // TODO build시에 펼칠수가 없어서 다른 Component로 넘어가야하나 고민중
              return ExpansionTile(
                initiallyExpanded: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${shoppingList[index].title} ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' ${shoppingList[index].regdate}\n',
                            style: TextStyle(
                              color: ColorList.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                '지출\u{1F4B8}: ${addAmount(viewModel, shoppingList[index].title)}원',
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
                children: generateCheckBoxs(
                    context: context, title: shoppingList[index].title),
              );
            },
          );
        }
      },
    );
  }

  // 체크리스트 생성
  List<Widget> generateCheckBoxs({
    required BuildContext context,
    required String title,
  }) {
    List<Widget> widgetList = [];
    var viewModel = context.read<ShoppingViewModel>();
    List<CheckList> list = [];

    viewModel.getAllCheckList(title).then(
      (value) {
        for (var element in value) {
          widgetList.add(
            checkBoxComponent(
              title: title,
              id: element.id!,
              content: element.content,
              amount: element.amount,
              ischeck: element.ischeck,
            ),
          );
        }
      },
    ).catchError(
      (error) {
        developer.log("getAllCheckList is Error : ", error: error);
      },
    );

    if (list.isEmpty) {
      return widgetList;
    }

    return widgetList;
  }

  // 체크박스 컴포넌트
  Widget checkBoxComponent({
    required int id,
    required String content,
    required int amount,
    required bool ischeck,
    required String title,
  }) {
    return CheckboxListTile(
      title: Text(content),
      secondary: Text("\u{1F4B8} $amount원", style: TextStyle(fontSize: 15)),
      controlAffinity: ListTileControlAffinity.leading,
      value: ischeck,
      onChanged: (value) {
        context
            .read<ShoppingViewModel>()
            .refreshCheckBox(id: id, changeValue: value);
      },
      activeColor: Colors.green,
      checkColor: Colors.black,
    );
  }

  int addAmount(ShoppingViewModel viewModel, String title) {
    int total = 0;
    viewModel.getTotalAmount(title).then(
      (value) {
        total += value;
      },
    ).catchError((error) {
      developer.log("getAllCheckList is Error : ", error: error);
    });
    return total;
  }

  Future<List<Shopping>> _getAllShoppingLists(
          ShoppingViewModel viewModel) async =>
      await viewModel.getAllShoppingList();
}
