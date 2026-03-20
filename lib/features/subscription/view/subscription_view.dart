import 'package:flutter/material.dart';
import 'package:safqaseller/features/subscription/view/widgets/subscription_view_body.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});
  static const String routeName = 'subscription';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SubscriptionViewBody(),
    );
  }
}
