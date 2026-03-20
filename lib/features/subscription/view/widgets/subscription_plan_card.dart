import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/subscription/model/subscription_plan_model.dart';

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({super.key, required this.plan});

  final SubscriptionPlanModel plan;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),

          // ── Plan Name ──
          Text(
            plan.name,
            style: TextStyles.bold22(context).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20.h),

          // ── Megaphone Icon ──
          Icon(
            Icons.campaign_outlined,
            size: 64.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 16.h),

          // ── Price ──
          Text(
            plan.price,
            style: TextStyles.bold28(context).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 32.h),

          // ── Feature List ──
          ...plan.features.map(
            (feature) => Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyles.regular13(context).copyWith(
                        color: const Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // ── CTA Button ──
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 0,
              ),
              child: Text(
                plan.ctaLabel,
                style: TextStyles.semiBold16(context).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
