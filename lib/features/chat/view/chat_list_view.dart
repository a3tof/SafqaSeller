import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/features/chat/view/widgets/chat_list_view_body.dart';
import 'package:safqaseller/features/chat/view_model/chat_list/chat_list_view_model.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  static const String routeName = 'chat';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatListViewModel>()..loadConversations(),
      child: const ChatListViewBody(),
    );
  }
}
