import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/style/color.dart';
import 'package:refrigerator_map/util/global_variable.dart';
import 'package:refrigerator_map/view/common/calendar.dart';
import 'package:refrigerator_map/view/shopping/add_shopping_page.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
import 'package:refrigerator_map/view/common/floating_action_button.dart';
import 'package:refrigerator_map/view/shopping/shopping_item.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

/// 장보기 페이지
class ShoppingPage extends StatefulWidget {
  ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final List<bool> _isSelected = [true, false];
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomCalendar(widgetName: context.widget.toString()),
              ToggleButtons(
                onPressed: (index) {
                  setState(
                    () {
                      for (int i = 0; i < _isSelected.length; i++) {
                        _isSelected[i] = i == index;
                      }
                    },
                  );
                },
                fillColor: Colors.black,
                isSelected: _isSelected,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "장보기 목록",
                      style: TextStyle(
                        fontSize: 17,
                        color: _isSelected[0] == true
                            ? ColorList.white
                            : ColorList.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "장보기 완료",
                      style: TextStyle(
                        fontSize: 17,
                        color: _isSelected[1] == true
                            ? ColorList.white
                            : ColorList.black,
                      ),
                    ),
                  ),
                ],
              ),
              ShoppingItem(isSelected: _isSelected),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingActionButton(
        onTab: () async {
          await showAlartDialog();
        },
      ),
      bottomNavigationBar: BottomNaviBar(),
    );
  }

  Future<void> showAlartDialog() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("타이틀 입력"),
        content: ListTile(
          title: Text("장보기목록 타이틀을 입력해주세요."),
          subtitle: Form(
            key: _formKey,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '장보기 제목은 필수로 입력하셔야합니다.';
                }
                // TODO db타이틀 중복검사
                return null;
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                createShoppingListItem(
                    title: titleController.text,
                    regdate: DateTime.now().toIso8601String(),
                    isdone: false);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AddShoppingPage(title: titleController.text),
                  ),
                );
              }
            },
            child: Text("확인"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("취소"),
          ),
        ],
      ),
    );
  }

  createShoppingListItem({
    required String title,
    required String regdate,
    required bool isdone,
  }) {
    var viewModel = GlobalAccessContext.navigatorState.currentContext!
        .read<ShoppingViewModel>();
    viewModel.addShopingList(
        Shopping(title: title, regdate: regdate, isdone: isdone));
  }
}
