import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles.dart';

class MessageBox extends StatelessWidget {
  final Level level;
  final String text;

  const MessageBox({
    super.key,
    required this.level,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        gradient: LinearGradient(
          colors: [
            level.gradientColor1.withOpacity(0.4),
            level.gradientColor2.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/message.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(level.iconColor, BlendMode.srcIn),
          ),
          SizedBox(width: 12.w),
          Expanded(child: Text(text, style: Styles.messageBoxText))
        ],
      ),
    );
  }
}

enum Level {
  warning(
    iconColor: Styles.warningIconColor,
    gradientColor1: Styles.warningGradientColor1,
    gradientColor2: Styles.warningGradientColor2,
  ),
  error(
    iconColor: Styles.errorIconColor,
    gradientColor1: Styles.errorGradientColor1,
    gradientColor2: Styles.errorGradientColor2,
  );

  final Color iconColor;
  final Color gradientColor1;
  final Color gradientColor2;

  const Level({
    required this.iconColor,
    required this.gradientColor1,
    required this.gradientColor2,
  });
}
