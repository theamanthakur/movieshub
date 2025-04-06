import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyle {
  static const appBarText = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    // fontFamily: FontFamily.sFCompactDisplay,
  );

  static const defaultText = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
