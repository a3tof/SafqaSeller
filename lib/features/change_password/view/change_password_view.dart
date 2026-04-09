import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/change_password/view/widgets/change_password_view_body.dart';
import 'package:safqaseller/features/change_password/view_model/change_password/change_password_view_model.dart';
import 'package:safqaseller/generated/l10n.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  static const String routeName = 'changePassword';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePasswordViewModel>(),
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: S.of(context).kChangePassword,
        ),
        body: const ChangePasswordViewBody(),
      ),
    );
  }
}
