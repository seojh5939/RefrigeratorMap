import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/refrigerator.dart';
import 'package:refrigerator_map/viewModel/main_viewmodel.dart';

class HomeCategoryList extends StatelessWidget {
  final String label;
  const HomeCategoryList({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RenderRefrigeratorListTitle(label: label),
        RenderListView(label: label),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
        ),
      ],
    );
  }
}

/// 식재료 item ListView
class RenderListView extends StatelessWidget {
  final String label;
  const RenderListView({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.1,
      child: FutureBuilder(
          future: context.read<MainViewModel>().getItemsByPosition(label),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Error : ${snapshot.error}",
                  style: TextStyle(fontSize: 15),
                ),
              );
            } else {
              List<Refrigerator> list = snapshot.data;
              return list.length == 0
                  ? Container()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return RenderRefrigeratorItem(
                          label: list[index].name,
                          dDay: (int.parse(list[index].expdate) -
                                  int.parse(list[index].regdate))
                              .toString(),
                        );
                      },
                    );
            }
          }),
    );
  }
}

/// 실제 식재료 item
class RenderRefrigeratorItem extends StatelessWidget {
  String label;
  String dDay;
  RenderRefrigeratorItem({
    super.key,
    required this.label,
    required this.dDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Column(
          children: [
            Text(label),
            Text(
              dDay,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class RenderRefrigeratorListTitle extends StatelessWidget {
  final String label;
  const RenderRefrigeratorListTitle({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            top: 15,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        Divider(
          thickness: 3.5,
          indent: 8,
          endIndent: 10,
        ),
      ],
    );
  }
}
