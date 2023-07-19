import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/checklist.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/view/shopping/add_shopping_item.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

/// 장보기 목록 추가 페이지
class AddShoppingPage extends StatefulWidget {
  AddShoppingPage({required this.title});
  String title;

  @override
  State<AddShoppingPage> createState() => _AddShoppingPageState();
}

class _AddShoppingPageState extends State<AddShoppingPage> {
  List<Shopping> tempList = [];
  final contentController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                ListTile(
                  title: Text(
                    "등록일",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      readOnly: true,
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
                    viewModel.addCheckList(
                      CheckList(
                          title: widget.title,
                          content: contentController.text,
                          amount: int.parse(amountController.text),
                          ischeck: false),
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
              child: Center(
                child: FutureBuilder(
                  future: _futureCheckList(viewModel, widget.title),
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
                      List<CheckList> data = snapshot.data;
                      return data.isEmpty
                          ? Container()
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return AddShoppingItem(
                                  index: index,
                                  list: data,
                                );
                              },
                            );
                    }
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      elevation: MaterialStateProperty.all(3)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
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

  Future<List<CheckList>> _futureCheckList(
          ShoppingViewModel viewModel, String title) async =>
      await viewModel.getAllCheckList(title);
}
