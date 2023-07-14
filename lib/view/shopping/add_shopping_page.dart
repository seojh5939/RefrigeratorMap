import 'package:flutter/material.dart';
import 'package:refrigerator_map/view/shopping/add_shopping_item.dart';

/// 장보기 목록 추가 페이지
class AddShoppingPage extends StatelessWidget {
  AddShoppingPage({super.key});

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      controller: titleController,
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
                  onPressed: () {},
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
                itemBuilder: (context, index) {
                  return AddShoppingItem();
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
