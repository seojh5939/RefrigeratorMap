import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // CustomCalendar(widgetName: context.widget.toString()),
              RenderToggleButtons(),
              ShoppingItem(),
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

  // 장보기 item 생성 다이얼로그
  Future<void> showAlartDialog() async {
    return showDialog(
      barrierDismissible: false,
      context: GlobalAccessContext.navigatorState.currentContext!,
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
                // ViewModel Init
                var viewModel = GlobalAccessContext
                    .navigatorState.currentContext!
                    .read<ShoppingViewModel>();

                viewModel
                    .getShoppingListByTitle(titleController.text)
                    .then((value) {
                  if (value == null) {
                    // Insert DB
                    viewModel.addShopingList(
                      Shopping(
                        title: titleController.text,
                        regdate: DateFormat('yyyyMMdd').format(DateTime.now()),
                        isdone: false,
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AddShoppingPage(title: titleController.text),
                      ),
                    );
                  } else {
                    RenderShowDialogForException(context);
                  }
                });
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

  /// 장보기 제목 중복시 보여줄 다이얼로그
  void RenderShowDialogForException(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        alignment: Alignment.center,
        content: Text("이미 존재합니다. 다른이름을 사용해주세요."),
        contentTextStyle: TextStyle(fontSize: 17, color: Colors.black),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }
}

class RenderToggleButtons extends StatefulWidget {
  const RenderToggleButtons({super.key});

  @override
  State<RenderToggleButtons> createState() => _RenderToggleButtonsState();
}

class _RenderToggleButtonsState extends State<RenderToggleButtons> {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ShoppingViewModel>();
    return ToggleButtons(
      onPressed: (index) => viewModel.changeSelectedToggle(index),
      fillColor: Colors.black,
      isSelected: context.watch<ShoppingViewModel>().isSelectedToggleBtn,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "장보기 목록",
            style: TextStyle(
              fontSize: 17,
              color:
                  context.watch<ShoppingViewModel>().isSelectedToggleBtn[0] ==
                          true
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
              color:
                  context.watch<ShoppingViewModel>().isSelectedToggleBtn[1] ==
                          true
                      ? ColorList.white
                      : ColorList.black,
            ),
          ),
        ),
      ],
    );
  }
}
