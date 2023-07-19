import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:refrigerator_map/util/global_variable.dart';
import 'package:refrigerator_map/view/home/home_page.dart';
import 'package:refrigerator_map/viewModel/bottom_navi_viewmodel.dart';
import 'package:refrigerator_map/viewModel/shopping_viewmodel.dart';

import 'viewModel/diet_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BottomNaviViewModel()),
          ChangeNotifierProvider(create: (context) => ShoppingViewModel()),
          ChangeNotifierProvider(create: (context) => DietViewModel()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalAccessContext.navigatorState,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
