import 'package:flutter/material.dart';
import 'package:refrigerator_map/style/color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({required this.onTab});
  void Function() onTab;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "fBtn1",
      backgroundColor: ColorList.black,
      onPressed: onTab,
      child: Icon(Icons.add, color: ColorList.white),
    );
  }
}
