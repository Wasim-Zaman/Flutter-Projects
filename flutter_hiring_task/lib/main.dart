import 'package:flutter/material.dart';

import './pages/overview_page.dart';
import './pages/items_detail.dart';
import './pages/map_view.dart';
import './pages/new_map_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          // headline2: TextStyle(
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          // ),
          // headline3: TextStyle(
          //   fontSize: 16,
          //   fontWeight: FontWeight.bold,
          // ),
          // headline4: TextStyle(
          //   fontSize: 14,
          //   fontWeight: FontWeight.bold,
          // ),
          // headline5: TextStyle(
          //   fontSize: 12,
          //   fontWeight: FontWeight.bold,
          // ),
          // headline6: TextStyle(
          //   fontSize: 10,
          //   fontWeight: FontWeight.bold,
          // ),
          // bodyText1: TextStyle(
          //   fontSize: 16,
          // ),
          // bodyText2: TextStyle(
          //   fontSize: 14,
          // ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mobile app test',
      initialRoute: OverviewPage.routeName,
      routes: {
        OverviewPage.routeName: (context) => const OverviewPage(),
        ItemsDetail.routeName: (context) => const ItemsDetail(),
        MapView.routeName: (context) => const MapView(),
        NewMapView.routeName: (context) => const NewMapView(),
      },
    );
  }
}
