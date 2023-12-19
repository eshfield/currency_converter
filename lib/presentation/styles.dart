import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  static const scaffoldColor = Color(0xFFFBFCFC);

  static const accentColor = Color(0xFFEE3F58);

  static const appBarColor = Color(0xFFEDF2FE);

  static const black23Color = Color(0xFF232323);

  static const navBarSelectedColor = Color(0xFF1F50E8);

  static const tabBarLabelSelectedColor = Colors.white;
  static const tabBarLabelUnselectedColor = Color(0xFF999999);

  static const warningIconColor = Color(0xFFFF730D);
  static const warningGradientColor1 = Color(0xFFFCEABB);
  static const warningGradientColor2 = Color(0xFFFFEBB6);

  static const errorIconColor = Color(0xFFFF0D0D);
  static const errorGradientColor1 = Color(0xFFFCBBBB);
  static const errorGradientColor2 = Color(0xFFFFEBB6);

  static const currencyRadioItemColor = Color(0xFFEFF5F9);

  static const applyButtonColor = Color(0xFF2454E8);

  static const repeatButtonLabelColor = Color(0XFF424242);

  static const currencySectionFromColor = Color(0xFFD8ECFF);
  static const currencySectionToColor = Color(0xFFF6DEFE);

  static final bottomSheetBarrierColor =
      const Color(0xFF090814).withOpacity(0.2);

  static final appBarTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static final navBarLabel = TextStyle(
    color: Colors.black.withOpacity(0.4),
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
  );

  static final tabBarLabel = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static final tabBarSelectedLabel =
      tabBarLabel.copyWith(color: tabBarLabelSelectedColor);

  static final tabBarUnselectedLabel =
      tabBarLabel.copyWith(color: tabBarLabelUnselectedColor);

  static final title = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
  );

  static final applyButtonLabel = TextStyle(
    color: Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static final repeatButtonLabel = TextStyle(
    color: repeatButtonLabelColor,
    fontSize: 24.sp,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );

  static final messageBoxText = TextStyle(
    color: Colors.black,
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );

  static final currencySectionLabel = TextStyle(
    color: Colors.black.withOpacity(0.5),
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.1,
  );

  static final currencySectionInput = TextStyle(
    color: black23Color,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static final currencySectionName = TextStyle(
    color: black23Color,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final currencySectionRate = TextStyle(
    color: Colors.black.withOpacity(0.5),
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    height: 1.2,
  );

  static final currencyRadioName = TextStyle(
    color: black23Color,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static final footer = TextStyle(
    color: Colors.black.withOpacity(0.4),
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );

  static final bottomSheetTitle = TextStyle(
    color: black23Color,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );
}
