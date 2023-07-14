import 'package:flutter/material.dart';

class AddShoppingItem extends StatelessWidget {
  const AddShoppingItem({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Column(
      children: [
        CheckboxListTile(
          title: Text('장보기 1'),
          subtitle: Text(
            "\u{1F4B8} ooo원",
            style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w700,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: isChecked,
          onChanged: (value) {},
          activeColor: Colors.green,
          checkColor: Colors.black,
        ),
      ],
    );
  }
}
