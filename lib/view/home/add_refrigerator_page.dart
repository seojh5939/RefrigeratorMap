import 'package:flutter/material.dart';

/// 냉장고 식재료 추가 페이지
class AddRefrigeratorPage extends StatelessWidget {
  const AddRefrigeratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text("냉장고에 어떤 식재료를 추가하시겠어요?",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                SizedBox(height: 25.0),
                RenderTextFormField(
                  label: '식재료명',
                  onSaved: (newValue) {},
                  validator: (value) {},
                ),
                RenderCountWidget(label: '수량'),
                RenderTextFormField(
                    label: '등록일',
                    onSaved: (newValue) {},
                    validator: (value) {},
                    readOnly: true),
                RenderTextFormField(
                  label: '유통기한',
                  onSaved: (newValue) {},
                  validator: (value) {},
                  readOnly: true,
                ),
                RenderDropDownButton(label: '위치'),
                RenderTextFormField(
                  label: "메모",
                  onSaved: (newValue) {},
                  validator: (value) {},
                  maxLength: 150,
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

/// 위치 Widget
class RenderDropDownButton extends StatefulWidget {
  final String label;
  String? _dropdownValue;
  List<String> list = ["냉장실", "냉동실", "신선칸"];
  RenderDropDownButton({
    super.key,
    required this.label,
  }) {
    _dropdownValue = list.first;
  }

  @override
  State<RenderDropDownButton> createState() => _RenderDropDownButtonState();
}

/// 위치 Widget
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
          value: widget._dropdownValue,
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
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

/// 식재료명, 등록일, 유통기한 Widget
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

/// 수량 Widget
class RenderCountWidget extends StatefulWidget {
  final String label;
  const RenderCountWidget({
    super.key,
    required this.label,
  });

  @override
  State<RenderCountWidget> createState() => _RenderCountWidgetState();
}

/// 수량 Widget
class _RenderCountWidgetState extends State<RenderCountWidget> {
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.label,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_count > 0) {
                    --_count;
                  }
                });
              },
            ),
            Text(_count.toString(), style: TextStyle(fontSize: 18)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  ++_count;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
