import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import 'box_shadow.dart';

class ApplyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ApplyButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        boxShadow: [boxShadow],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(100.r),
        color: Styles.applyButtonColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(100.r),
          onTap: onTap,
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                label,
                style: Styles.applyButtonLabel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
