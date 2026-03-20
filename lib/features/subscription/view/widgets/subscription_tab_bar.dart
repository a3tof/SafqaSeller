import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

class SubscriptionTabBar extends StatelessWidget {
  const SubscriptionTabBar({
    super.key,
    required this.tabController,
    required this.labels,
  });

  final TabController tabController;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.primaryColor,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primaryColor,
        labelStyle: TextStyles.semiBold13(context),
        unselectedLabelStyle: TextStyles.regular13(context),
        splashBorderRadius: BorderRadius.circular(20.r),
        tabs: labels.map((label) => Tab(text: label)).toList(),
      ),
    );
  }
}
