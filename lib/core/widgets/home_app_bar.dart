import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';

SliverAppBar buildHomeAppBar({
  required BuildContext context,
  required String title,
  bool pinned = false,
}) {
  return SliverAppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    automaticallyImplyLeading: false,
    pinned: pinned,
    floating: false,
    snap: false,
    elevation: 0,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        letterSpacing: 1.5,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
        fontFamily: 'Alegreya SC',
      ),
    ),
  );
}
