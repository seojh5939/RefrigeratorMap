import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/view/shopping/add_shopping_item.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

/// 장보기 목록 추가 페이지
class AddShoppingPage extends StatefulWidget {
  AddShoppingPage({super.key});

  @override
  State<AddShoppingPage> createState() => _AddShoppingPageState();
}

class _AddShoppingPageState extends State<AddShoppingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final amountController = TextEditingController();

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
                if (value == null || value.isEmpty)
                  return '장보기 제목은 필수로 입력하셔야합니다.';
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
                Navigator.pop(context);
              }
            },
            child: Text("예"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("아니오"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (titleController.text == null || titleController.text == "") {
        await showAlartDialog();
      }
    });
    ShoppingViewModel viewModel = context.read<ShoppingViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("장보기 목록 생성",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Column(
              children: [
                ListTile(
                  title: Text(
                    "내용",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "금액",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      elevation: MaterialStateProperty.all(3)),
                  onPressed: () {
                    viewModel.addShopingList(
                      Shopping(
                        title: titleController.text,
                        dttm: "dttm",
                        content: contentController.text,
                        amount: int.parse(amountController.text),
                      ),
                    );
                  },
                  child: Text(
                    "등록",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.shoppingList.length,
                itemBuilder: (context, index) {
                  return AddShoppingItem(index: index);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      elevation: MaterialStateProperty.all(3)),
                  onPressed: () {},
                  child: Text(
                    "저장",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      elevation: MaterialStateProperty.all(3)),
                  onPressed: () {},
                  child: Text(
                    "취소",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
