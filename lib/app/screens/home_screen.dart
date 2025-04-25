import 'package:flutter/material.dart';
import 'package:weather/app/pages/home/forecast_page.dart';

import '../pages/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomePage(),
            ForecastPage(),
            AppMorePage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              text: 'ယနေ့',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'ခန့်မှန်းချက်များ',
              icon: Icon(Icons.cloud_outlined),
            ),
            Tab(
              text: 'More',
              icon: Icon(Icons.grid_view_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
