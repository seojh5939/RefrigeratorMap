import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/refrigerator.dart';
import 'package:refrigerator_map/viewModel/main_viewmodel.dart';

/// 냉장고 식재료 추가 페이지
class AddRefrigeratorPage extends StatelessWidget {
  String? name;
  int? count;
  String? regDate;
  String? expDate;
  String? position;
  String? memo;

  AddRefrigeratorPage({
    super.key,
    this.name,
    this.count,
    this.regDate,
    this.expDate,
    this.position,
    this.memo,
  });

  var nameController = TextEditingController();
  var regDateController = TextEditingController();
  var expDateController = TextEditingController();
  var memoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    initPageData();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(name == null ? "냉장고에 어떤 식재료를 추가하시겠어요?" : "식재료 정보",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  SizedBox(height: 25.0),
                  Row(
                    children: [
                      Text("식재료명",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: nameController,
                    onSaved: (newValue) {
                      nameController.text = newValue ?? "";
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '식재료명은 반드시 입력해야합니다.';
                      }
                      // TODO db 중복검사
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  RenderCountWidget(
                    label: '수량',
                    count: count ?? 1,
                  ),
                  Row(
                    children: [
                      Text("등록일",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: regDateController,
                    onSaved: (newValue) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '구입하신 일자를 등록해주세요!';
                      }
                      return null;
                    },
                    onTap: () async {
                      var selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (selected != null) {
                        var selectedDate =
                            (DateFormat('yyyyMMdd')).format(selected);
                        regDateController.text = selectedDate.toString();
                      }
                    },
                    readOnly: true,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text("유통기한",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: expDateController,
                    onSaved: (newValue) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'D-Day계산을위해 유통기한 입력을 해주셔야합니다.';
                      }
                      return null;
                    },
                    onTap: () async {
                      var selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (selected != null) {
                        var selectedDate =
                            (DateFormat('yyyyMMdd')).format(selected);
                        expDateController.text = selectedDate.toString();
                      }
                    },
                    readOnly: true,
                  ),
                  SizedBox(height: 20.0),
                  RenderDropDownButton(
                    label: '위치',
                    position: position,
                  ),
                  Row(
                    children: [
                      Text("메모",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: memoController,
                    maxLength: 150,
                    onSaved: (newValue) {},
                    validator: (value) {},
                  ),
                  SizedBox(height: 20.0),
                  RenderElevatedButton(
                    formKey: _formKey,
                    nameController: nameController,
                    regDateController: regDateController,
                    expDateController: expDateController,
                    memoController: memoController,
                    count: count,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 페이지 데이터 Init
  initPageData() {
    nameController.text = name ?? "";
    regDateController.text = regDate ?? "";
    expDateController.text = expDate ?? "";
    if (memo == "null") {
      memoController.text = "";
    } else {
      memoController.text = memo!;
    }
  }
}

class RenderElevatedButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final nameController;
  final int? count;
  final regDateController;
  final expDateController;
  final memoController;

  const RenderElevatedButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.count,
    required this.regDateController,
    required this.expDateController,
    required this.memoController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
          onPressed: () {
            var validateResult = formKey.currentState!.validate() ?? false;
            if (validateResult) {
              formKey.currentState!.save();
              // TODO 저장전 name 중복여부 확인 후 예외처리
              context.read<MainViewModel>().addItems(Refrigerator(
                    name: nameController.text,
                    count: count ?? 1,
                    regdate: regDateController.text,
                    expdate: expDateController.text,
                    position: context.read<MainViewModel>().dropdownValue,
                  ));

              SnackBar(content: Text("저장되었습니다."));
              Navigator.pop(context);
            }
          },
          child: Text(
            "저장",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        SizedBox(width: 25, height: 100),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
          onPressed: () {
            Navigator.pop(context);
          },
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
class RenderDropDownButton extends StatelessWidget {
  const RenderDropDownButton({super.key, required this.label, this.position});

  final String label;
  final String? position;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<MainViewModel>();
    var dropdownValue =
        position ?? context.watch<MainViewModel>().dropdownValue;
    var list = viewModel.list;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
          ],
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            viewModel.applyDropdownValue(value);
          },
        ),
        SizedBox(height: 20.0)
      ],
    );
  }
}

/// 식재료명, 등록일, 유통기한 Widget
class RenderTextFormField extends StatelessWidget {
  final formKey;
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  TextEditingController? controller;
  bool readOnly;
  int? maxLength;

  RenderTextFormField({
    super.key,
    required this.formKey,
    required this.label,
    required this.onSaved,
    required this.validator,
    this.controller,
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
          controller: controller,
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
  int count;

  RenderCountWidget({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  State<RenderCountWidget> createState() => _RenderCountWidgetState();
}

/// 수량 Widget
class _RenderCountWidgetState extends State<RenderCountWidget> {
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
                  if (widget.count > 0) {
                    --widget.count;
                  }
                });
              },
            ),
            Text(widget.count.toString(), style: TextStyle(fontSize: 18)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  ++widget.count;
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
