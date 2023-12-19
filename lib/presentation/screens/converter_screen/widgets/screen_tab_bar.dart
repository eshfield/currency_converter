import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/box_shadow.dart';
import '../../../styles.dart';

class ScreenTabBar extends StatelessWidget {
  const ScreenTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        boxShadow: [boxShadow],
        color: Colors.white,
      ),
      height: 50.h,
      padding: EdgeInsets.all(4.r),
      child: TabBar(
        dividerHeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: Styles.accentColor,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Styles.tabBarLabelSelectedColor,
        labelStyle: Styles.tabBarSelectedLabel,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        splashBorderRadius: BorderRadius.circular(100.r),
        tabs: [
          Tab(text: l10n.tabConverterLabel),
          Tab(text: l10n.tabRatesLabel),
        ],
        unselectedLabelStyle: Styles.tabBarUnselectedLabel,
      ),
    );
  }
}
