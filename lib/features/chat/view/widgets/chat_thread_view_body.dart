import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/chat/model/models/chat_models.dart';
import 'package:safqaseller/features/chat/view/chat_thread_view_args.dart';
import 'package:safqaseller/features/chat/view/widgets/message_bubble.dart';
import 'package:safqaseller/features/chat/view_model/chat_thread/chat_thread_view_model.dart';
import 'package:safqaseller/features/chat/view_model/chat_thread/chat_thread_view_model_state.dart';
import 'package:safqaseller/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChatThreadViewBody extends StatefulWidget {
  const ChatThreadViewBody({super.key, required this.args});

  final ChatThreadViewArgs args;

  @override
  State<ChatThreadViewBody> createState() => _ChatThreadViewBodyState();
}

class _ChatThreadViewBodyState extends State<ChatThreadViewBody> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    _messageController.clear();
    context.read<ChatThreadViewModel>().sendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocListener<ChatThreadViewModel, ChatThreadState>(
      listenWhen: (previous, current) {
        return previous is ChatThreadSuccess
            ? current is ChatThreadSuccess &&
                  current.sendErrorMessage != null &&
                  current.sendErrorMessage != previous.sendErrorMessage
            : current is ChatThreadSuccess && current.sendErrorMessage != null;
      },
      listener: (context, state) {
        final success = state as ChatThreadSuccess;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success.sendErrorMessage ?? s.chatSendFailed)),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColor,
              size: 22.sp,
            ),
          ),
          title: Text(
            widget.args.buyerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.bold22(context).copyWith(
              color: AppColors.primaryColor,
              fontFamily: Localizations.localeOf(context).languageCode == 'ar'
                  ? 'Cairo'
                  : 'AlegreyaSC',
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatThreadViewModel, ChatThreadState>(
                  builder: (context, state) {
                    if (state is ChatThreadInitial ||
                        state is ChatThreadLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: _ChatMessagesList(
                          messages: _skeletonMessages,
                          onRefresh: () async {},
                          emptyText: s.chatNoMessages,
                        ),
                      );
                    }

                    if (state is ChatThreadFailure) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: TextStyles.regular16(context),
                              ),
                              SizedBox(height: 16.h),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<ChatThreadViewModel>()
                                    .loadMessages(widget.args.conversationId),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(s.retry),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final success = state as ChatThreadSuccess;
                    return _ChatMessagesList(
                      messages: success.messages,
                      onRefresh: () =>
                          context.read<ChatThreadViewModel>().refresh(),
                      emptyText: s.chatNoMessages,
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: TextField(
                          controller: _messageController,
                          minLines: 1,
                          maxLines: 4,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                          style: TextStyles.regular14(context),
                          decoration: InputDecoration(
                            hintText: s.chatTypeMessage,
                            hintStyle: TextStyles.regular14(
                              context,
                            ).copyWith(color: const Color(0xFF999999)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    BlocBuilder<ChatThreadViewModel, ChatThreadState>(
                      builder: (context, state) {
                        final isSending =
                            state is ChatThreadSuccess && state.isSending;
                        return InkWell(
                          borderRadius: BorderRadius.circular(14.r),
                          onTap: isSending ? null : _sendMessage,
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: isSending
                                ? Padding(
                                    padding: EdgeInsets.all(12.r),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                    size: 22.sp,
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessagesList extends StatelessWidget {
  const _ChatMessagesList({
    required this.messages,
    required this.onRefresh,
    required this.emptyText,
  });

  final List<MessageModel> messages;
  final Future<void> Function() onRefresh;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 720 ? 620.0 : double.infinity;

          return ListView(
            reverse: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: messages.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: Center(
                            child: Text(
                              emptyText,
                              style: TextStyles.regular16(
                                context,
                              ).copyWith(color: const Color(0xFF777777)),
                            ),
                          ),
                        )
                      : Column(
                          children: messages
                              .map(
                                (message) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: MessageBubble(message: message),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

final List<MessageModel> _skeletonMessages = [
  MessageModel(
    id: 1,
    conversationId: 1,
    content: 'Hello, I would like to ask about the item details.',
    sentAt: DateTime.now(),
    isMine: false,
  ),
  MessageModel(
    id: 2,
    conversationId: 1,
    content: 'Sure, I can share the details with you.',
    sentAt: DateTime.now(),
    isMine: true,
  ),
];
