import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/features/notifications/view/widgets/notifications_view_body.dart';
import 'package:safqaseller/features/notifications/view_model/notifications/notifications_view_model.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  static const String routeName = 'notifications';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NotificationsViewModel>(),
      child: const NotificationsViewBody(),
    );
  }
}
