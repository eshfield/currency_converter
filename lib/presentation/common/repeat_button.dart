import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';

class RepeatButton extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const RepeatButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Styles.accentColor),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                blurRadius: 10.r,
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          ),
          width: double.infinity,
          height: 56,
          child: Center(
            child: Text(
              label,
              style: Styles.repeatButtonLabel,
            ),
          ),
        ),
      ),
    );
  }
}
