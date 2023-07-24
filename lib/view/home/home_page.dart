import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/data/model/refrigerator.dart';
import 'package:refrigerator_map/util/global_variable.dart';
import 'package:refrigerator_map/view/common/bottom_navi_bar.dart';
import 'package:refrigerator_map/view/common/floating_action_button.dart';
import 'package:refrigerator_map/view/home/home_category_list.dart';
import 'package:refrigerator_map/view/home/add_refrigerator_page.dart';
import 'package:refrigerator_map/viewModel/main_viewmodel.dart';

/// 메인 페이지
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var list = context.read<MainViewModel>().list; // 보관칸 저장 리스트
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return HomeCategoryList(label: list[index]);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "removeBtn1",
            backgroundColor: Colors.black,
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("품목 삭제하기"),
                    content: ListTile(
                      title: Text("삭제하실 품목을 선택해주세요. \n"),
                      subtitle: FutureBuilder(
                        future: context.read<MainViewModel>().getAllItems(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                            List<Refrigerator> dataList = snapshot.data;
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: GridView.count(
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 5 / 2.5,
                                crossAxisCount: 2,
                                children: itemList(dataList),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("확인"),
                      ),
                    ],
                  );
                },
              )
            },
            child: Icon(Icons.delete, color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
          CustomFloatingActionButton(
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddRefrigeratorPage(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNaviBar(),
    );
  }

  List<Widget> itemList(List<Refrigerator> list) {
    List<Widget> widgetList = [];
    for (var item in list) {
      widgetList.add(
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.grey,
            ),
          ),
          onPressed: () {
            showDialog(
                context: GlobalAccessContext.navigatorState.currentContext!,
                builder: (context) {
                  return AlertDialog(
                    title: Text("삭제하시겠습니까?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            context.read<MainViewModel>().removeItems(item.id!);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("확인")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("취소")),
                    ],
                  );
                });
          },
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "${item.position} \n",
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w700)),
                TextSpan(
                    text: item.name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      );
    }
    return widgetList;
  }
}
