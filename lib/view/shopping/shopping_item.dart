import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/checklist.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/style/color.dart';
import 'package:refrigerator_map/view/shopping/add_shopping_page.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';
import 'dart:developer' as developer;

/// 장보기 item
class ShoppingItem extends StatelessWidget {
  ShoppingItem({super.key});

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
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: shoppingList.length,
            itemBuilder: (context, index) {
              // 장보기 제목 && 체크박스
              return RenderExpansionTile(
                index: index,
                title: shoppingList[index].title,
                shoppingList: shoppingList,
              );
            },
          );
        }
      },
    );
  }

  /// 모든 장보기목록 조회
  Future<List<Shopping>> _getAllShoppingLists(
          ShoppingViewModel viewModel) async =>
      await viewModel.getAllShoppingList();
}

/// 장보기 제목&&체크박스
class RenderExpansionTile extends StatelessWidget {
  final int index;
  final List<Shopping> shoppingList;
  final String title;

  RenderExpansionTile({
    super.key,
    required this.index,
    required this.shoppingList,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _createCheckBoxListTileWidgetLists(context),
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
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Align(
                    alignment: Alignment.centerLeft, child: Icon(Icons.edit)),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete)),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                print("Edit");
              } else {
                print("remove");
              }
            },
            confirmDismiss: (direction) {
              if (direction == DismissDirection.startToEnd) {
                return _showDialogEditOrRemove(
                  context,
                  "수정하기",
                  "수정하시겠습니까?",
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddShoppingPage(title: title),
                      ),
                    );
                  },
                  () {
                    Navigator.pop(context);
                    context.read<ShoppingViewModel>().refreshPage();
                  },
                );
              } else {
                return _showDialogEditOrRemove(
                  context,
                  "삭제하기",
                  "삭제하시겠습니까?",
                  () {
                    Navigator.pop(context);
                    context
                        .read<ShoppingViewModel>()
                        .removeShoppingList(shoppingList[index].id!);
                  },
                  () {
                    Navigator.pop(context);
                    context.read<ShoppingViewModel>().refreshPage();
                  },
                );
              }
            },
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RenderRichText(shoppingList: shoppingList, index: index),
                  RenderSwitch(title: title),
                ],
              ),
              children: snapshot.data,
            ),
          );
        }
      },
    );
  }

  _showDialogEditOrRemove(BuildContext context, String label, String content,
      void Function() onConfirm, void Function() onCancel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(label),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: onConfirm,
            child: Text("확인"),
          ),
          TextButton(
            onPressed: onCancel,
            child: Text("취소"),
          ),
        ],
      ),
    );
  }

  /// CheckBoxListTile 생성 후 Widget에 Add
  Future<List<Widget>> _createCheckBoxListTileWidgetLists(
      BuildContext context) async {
    List<Widget> widgetList = [];
    List<CheckList> list =
        await context.read<ShoppingViewModel>().getAllCheckList(title);
    widgetList = List.generate(
      list.length,
      (index) => CheckboxListTile(
        title: Text(list[index].content),
        secondary: Text("\u{1F4B8} ${list[index].amount}원",
            style: TextStyle(fontSize: 15)),
        controlAffinity: ListTileControlAffinity.leading,
        value: list[index].ischeck,
        onChanged: (value) {
          context
              .read<ShoppingViewModel>()
              .refreshCheckBox(id: list[index].id!, changeValue: value);
        },
        activeColor: Colors.green,
        checkColor: Colors.black,
      ),
    );
    return widgetList;
  }
}

class RenderSwitch extends StatelessWidget {
  final String title;

  const RenderSwitch({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ShoppingViewModel>().getShoppingListByTitle(title),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Error : ${snapshot.error}",
              style: TextStyle(fontSize: 15),
            ),
          );
        } else {
          var data = snapshot.data;
          return Column(
            children: [
              Text(
                "장보기완료",
                style: TextStyle(fontSize: 10),
              ),
              Switch(
                value: data.isdone,
                onChanged: (value) {
                  context.read<ShoppingViewModel>().updateIsDone(
                      data.id.toString(), value == true ? "1" : "0");
                },
              ),
            ],
          );
        }
      },
    );
  }
}

/// 장보기 목록 제목, 날짜, 금액
class RenderRichText extends StatelessWidget {
  final List<Shopping> shoppingList;
  final int index;

  const RenderRichText({
    super.key,
    required this.shoppingList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '${shoppingList[index].title} ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                '지출\u{1F4B8}: ${totalAmount(context, shoppingList[index].title)}원',
            style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// 장보기 금액 투두리스트 총합
  int totalAmount(BuildContext context, String title) {
    int total = 0;
    context.read<ShoppingViewModel>().getTotalAmount(title).then(
      (value) {
        total += value;
      },
    ).catchError((error) {
      developer.log("getAllCheckList is Error : ", error: error);
    });
    return total;
  }
}
