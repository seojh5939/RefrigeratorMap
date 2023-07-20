import 'package:flutter/material.dart';

/// 식단표 추가 페이지
class AddDietPage extends StatelessWidget {
  List<String> mealTimeList;
  AddDietPage({super.key, required this.mealTimeList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "뭘 먹어야 잘 먹었다고 소문이 날까?",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 35.0),
                RenderTextFormField(
                  label: "음식명",
                  onSaved: (newValue) {},
                  validator: (value) {},
                ),
                RenderTextFormField(
                  label: "날짜",
                  onSaved: (newValue) {},
                  validator: (value) {},
                  readOnly: true,
                ),
                RenderDropDownButton(
                  label: "언제 드실건가요?",
                  mealTimeList: mealTimeList,
                ),
                RenderTextFormField(
                  label: "메모",
                  onSaved: (newValue) {},
                  validator: (value) {},
                  maxLength: 150,
                ),
                RenderMuckitList(
                  label: "먹킷리스트",
                  buttonLabel: "추가",
                  onSaved: (value) {},
                  validator: (value) {},
                  onPressed: () {},
                ),
                RenderMuckitListItems(
                  onPressed: () {},
                ),
                RenderElevatedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RenderElevatedButton extends StatelessWidget {
  const RenderElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
          onPressed: () {},
          child: Text(
            "저장",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        SizedBox(width: 25, height: 100),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
          onPressed: () {},
          child: Text(
            "취소",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        )
      ],
    );
  }
}

/// 먹킷리스트 작성시 아래 생기는 Item 생성기
class RenderMuckitListItems extends StatelessWidget {
  final List<String> dummyList = [
    "불족발불족발불족발불불족발불족발불족발불불족발불족발불족발불",
    "냉면",
    "치킨",
    "막국수",
    "김치찌게",
    "된장찌게",
    "순두부찌게",
    "불족발불족발불족발불불족발불족발불족발불불족발불족발불족발불",
    "냉면",
    "치킨",
    "막국수",
    "김치찌게",
    "된장찌게",
    "순두부찌게",
  ];
  final void Function() onPressed;
  RenderMuckitListItems({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.count(
        shrinkWrap: true,
        primary: false,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 1.6,
        padding: EdgeInsets.all(15),
        children: dummyList.map((value) {
          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
            ),
            onPressed: onPressed,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// 먹킷리스트
class RenderMuckitList extends StatelessWidget {
  final String label;
  final String buttonLabel;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final void Function() onPressed;
  int? maxLength;
  RenderMuckitList({
    super.key,
    required this.label,
    required this.buttonLabel,
    required this.onSaved,
    required this.validator,
    required this.onPressed,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.67,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 15,
                onSaved: onSaved,
                validator: validator,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                ),
                onPressed: onPressed,
                child: Text(
                  "추가",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

/// 음식명, 날짜, 메모
class RenderTextFormField extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  bool readOnly;
  int? maxLength;
  RenderTextFormField({
    super.key,
    required this.label,
    required this.onSaved,
    required this.validator,
    this.readOnly = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
          ],
        ),
        TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          readOnly: readOnly,
          maxLength: maxLength,
          onSaved: (value) {},
          validator: (value) {},
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}

/// 언제드실건가요? 드롭다운버튼
class RenderDropDownButton extends StatefulWidget {
  final String label;
  String? _dropdownValue;
  List<String> mealTimeList;
  RenderDropDownButton({
    super.key,
    required this.label,
    required this.mealTimeList,
  }) {
    _dropdownValue = mealTimeList.first;
  }

  @override
  State<RenderDropDownButton> createState() => _RenderDropDownButtonState();
}

/// 언제드실건가요? 드롭다운버튼
class _RenderDropDownButtonState extends State<RenderDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.label,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
          ],
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: widget._dropdownValue,
          items:
              widget.mealTimeList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              widget._dropdownValue = value;
            });
          },
        ),
        SizedBox(height: 20.0)
      ],
    );
  }
}
