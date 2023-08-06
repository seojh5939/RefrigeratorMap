import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/checklist.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

/// 장보기 목록 추가 페이지
class AddShoppingPage extends StatefulWidget {
  AddShoppingPage({required this.title});

  String title;

  @override
  State<AddShoppingPage> createState() => _AddShoppingPageState();
}

class _AddShoppingPageState extends State<AddShoppingPage> {
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
                RenderListTile(label: "내용", controller: contentController),
                RenderListTile(label: "금액", controller: amountController),
                // RenderListTile(label: "등록일", readOnly: true),
                RenderElevatedButton(
                  viewModel: viewModel,
                  widget: widget,
                  contentController: contentController,
                  amountController: amountController,
                  onPressed: () {
                    // TODO 빈 문자열 검사
                    viewModel.addCheckList(
                      CheckList(
                        title: widget.title,
                        content: contentController.text,
                        amount: int.parse(amountController.text),
                        ischeck: false,
                      ),
                    );
                  },
                ),
              ],
            ),
            Consumer<ShoppingViewModel>(
              builder: (context, viewModel, child) {
                return RenderCheckBoxListTile(
                  title: widget.title,
                );
              },
            ),
            RenderOKButton(),
          ],
        ),
      ),
    );
  }
}

class RenderCheckBoxListTile extends StatelessWidget {
  String title;

  RenderCheckBoxListTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: FutureBuilder(
          future: _futureCheckList(context, title),
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
                        return RenderCheckboxListTile(
                          index: index,
                          list: data,
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }

  Future<List<CheckList>> _futureCheckList(
          BuildContext context, String title) async =>
      await context.read<ShoppingViewModel>().getAllCheckList(title);
}

class RenderCheckboxListTile extends StatelessWidget {
  RenderCheckboxListTile({required this.list, required this.index});

  int index;
  List<CheckList> list;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ShoppingViewModel>();
    return Column(
      children: [
        CheckboxListTile(
          title: Text(list[index].content),
          secondary: Text(
            "\u{1F4B8} ${list[index].amount}원",
            style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w700,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: list[index].ischeck,
          onChanged: (value) {
            viewModel.refreshCheckBox(changeValue: value, id: list[index].id!);
          },
          activeColor: Colors.green,
          checkColor: Colors.black,
        ),
      ],
    );
  }
}

class RenderOKButton extends StatelessWidget {
  const RenderOKButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            elevation: MaterialStateProperty.all(3)),
        onPressed: () {
          Navigator.pop(context);
          context.read<ShoppingViewModel>().refreshPage();
        },
        child: Text(
          "확인",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class RenderElevatedButton extends StatelessWidget {
  final ShoppingViewModel viewModel;
  final AddShoppingPage widget;
  final TextEditingController contentController;
  final TextEditingController amountController;
  final void Function()? onPressed;

  const RenderElevatedButton({
    super.key,
    required this.viewModel,
    required this.widget,
    required this.contentController,
    required this.amountController,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange),
          elevation: MaterialStateProperty.all(3)),
      onPressed: onPressed,
      child: Text(
        "등록",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class RenderListTile extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool? readOnly;

  const RenderListTile({
    super.key,
    required this.label,
    this.controller,
    this.onTap,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          onChanged: (value) {
            controller?.text = value;
          },
          readOnly: readOnly ?? false,
          onTap: onTap,
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
    );
  }
}
