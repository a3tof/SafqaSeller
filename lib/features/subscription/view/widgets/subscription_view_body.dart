import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/features/subscription/model/subscription_plan_model.dart';
import 'package:safqaseller/features/subscription/view/widgets/subscription_plan_card.dart';
import 'package:safqaseller/features/subscription/view/widgets/subscription_tab_bar.dart';

class SubscriptionViewBody extends StatefulWidget {
  const SubscriptionViewBody({super.key});

  @override
  State<SubscriptionViewBody> createState() => _SubscriptionViewBodyState();
}

class _SubscriptionViewBodyState extends State<SubscriptionViewBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 4.h),
          // ── SAFQA.Business Logo ──
          Center(child: _buildLogo()),
          SizedBox(height: 24.h),

          // ── Tab Bar ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: SubscriptionTabBar(
              tabController: _tabController,
              labels: const ['Basic', 'Premium', 'Elite'],
            ),
          ),
          SizedBox(height: 24.h),

          // ── Plan Cards ──
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: SubscriptionPlanModel.plans
                  .map((plan) => SubscriptionPlanCard(plan: plan))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'safqa',
            style: TextStyle(
              fontFamily: 'AlegreyaSC',
              fontSize: 40.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          TextSpan(
            text: '.',
            style: TextStyle(
              fontFamily: 'AlegreyaSC',
              fontSize: 40.sp,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF808080),
            ),
          ),
          TextSpan(
            text: 'Business',
            style: TextStyle(
              fontFamily: 'AlegreyaSC',
              fontSize: 24.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
