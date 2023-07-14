import 'package:flutter/material.dart';
import 'package:refrigerator_map/style/color.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
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
                      text: '장보기 목록 ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' 2023년 7월 14일\n',
                      style: TextStyle(
                        color: ColorList.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: '지출\u{1F4B8}: 50000원',
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
          children: [
            CheckboxListTile(
              title: Text('장보기 1'),
              secondary: Text("\u{1F4B8} ooo원", style: TextStyle(fontSize: 15)),
              controlAffinity: ListTileControlAffinity.leading,
              //TODO value에 shopping.iscomplete 연동하기.
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  //TODO 클릭시 수정페이지로 이동하기.
                });
              },
              activeColor: Colors.green,
              checkColor: Colors.black,
            ),
            CheckboxListTile(
              title: Text('장보기 1'),
              secondary: Text("\u{1F4B8} ooo원", style: TextStyle(fontSize: 15)),
              controlAffinity: ListTileControlAffinity.leading,
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
              activeColor: Colors.green,
              checkColor: Colors.black,
            ),
            CheckboxListTile(
              title: Text('장보기 1'),
              secondary: Text("\u{1F4B8} ooo원", style: TextStyle(fontSize: 15)),
              controlAffinity: ListTileControlAffinity.leading,
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
              activeColor: Colors.green,
              checkColor: Colors.black,
            ),
            CheckboxListTile(
              title: Text('장보기 1'),
              secondary: Text("\u{1F4B8} ooo원", style: TextStyle(fontSize: 15)),
              controlAffinity: ListTileControlAffinity.leading,
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
              activeColor: Colors.green,
              checkColor: Colors.black,
            ),
          ],
        );
      },
    );
  }
}
