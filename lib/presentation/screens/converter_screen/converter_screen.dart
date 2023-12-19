import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/tab_views/converter_tab_view.dart';
import 'widgets/tab_views/rates_tab_view.dart';
import 'widgets/screen_tab_bar.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.r, 10.r, 16.r, 16.r),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            const ScreenTabBar(),
            SizedBox(height: 16.h),
            const Expanded(
              child: TabBarView(
                children: [
                  ConverterTabView(),
                  RatesTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
