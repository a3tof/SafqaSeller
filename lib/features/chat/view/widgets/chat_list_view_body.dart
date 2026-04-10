import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/chat/model/models/chat_models.dart';
import 'package:safqaseller/features/chat/view/chat_thread_view.dart';
import 'package:safqaseller/features/chat/view/chat_thread_view_args.dart';
import 'package:safqaseller/features/chat/view/widgets/conversation_item.dart';
import 'package:safqaseller/features/chat/view_model/chat_list/chat_list_view_model.dart';
import 'package:safqaseller/features/chat/view_model/chat_list/chat_list_view_model_state.dart';
import 'package:safqaseller/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChatListViewBody extends StatefulWidget {
  const ChatListViewBody({super.key});

  @override
  State<ChatListViewBody> createState() => _ChatListViewBodyState();
}

class _ChatListViewBodyState extends State<ChatListViewBody> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });

    if (_isSearching) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _searchFocusNode.requestFocus();
        }
      });
    }
  }

  List<ConversationModel> _filterConversations(List<ConversationModel> items) {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return items;

    return items.where((item) {
      return item.buyerName.toLowerCase().contains(query) ||
          item.lastMessage.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: (_) => setState(() {}),
                style: TextStyles.medium16(
                  context,
                ).copyWith(color: AppColors.primaryColor),
                decoration: InputDecoration(
                  hintText: s.chatSearchHint,
                  hintStyle: TextStyles.regular14(
                    context,
                  ).copyWith(color: const Color(0xFF999999)),
                  border: InputBorder.none,
                ),
              )
            : Text(
                s.chatTitle,
                style: TextStyles.bold28(context).copyWith(
                  color: AppColors.primaryColor,
                  fontFamily:
                      Localizations.localeOf(context).languageCode == 'ar'
                      ? 'Cairo'
                      : 'AlegreyaSC',
                ),
              ),
        actions: [
          IconButton(
            onPressed: _toggleSearch,
            icon: Icon(
              _isSearching ? Icons.close_rounded : Icons.search_rounded,
              color: AppColors.primaryColor,
              size: 26.sp,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ChatListViewModel, ChatListState>(
        builder: (context, state) {
          if (state is ChatListInitial || state is ChatListLoading) {
            return Skeletonizer(
              enabled: true,
              child: _ChatListContent(
                conversations: _skeletonConversations,
                onRefresh: () async {},
              ),
            );
          }

          if (state is ChatListFailure) {
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
                      onPressed: () =>
                          context.read<ChatListViewModel>().loadConversations(),
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

          final conversations = _filterConversations(
            (state as ChatListSuccess).conversations,
          );

          return _ChatListContent(
            conversations: conversations,
            onRefresh: () => context.read<ChatListViewModel>().refresh(),
          );
        },
      ),
    );
  }
}

class _ChatListContent extends StatelessWidget {
  const _ChatListContent({
    required this.conversations,
    required this.onRefresh,
  });

  final List<ConversationModel> conversations;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 720 ? 560.0 : double.infinity;

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: conversations.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 64.sp,
                                color: Colors.grey[350],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                s.chatNoConversations,
                                style: TextStyles.regular16(
                                  context,
                                ).copyWith(color: const Color(0xFF777777)),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: conversations
                              .map(
                                (conversation) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: ConversationItem(
                                    conversation: conversation,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        ChatThreadView.routeName,
                                        arguments: ChatThreadViewArgs(
                                          conversationId: conversation.id,
                                          buyerName: conversation.buyerName,
                                        ),
                                      );
                                    },
                                  ),
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

final List<ConversationModel> _skeletonConversations = List.generate(
  6,
  (index) => ConversationModel(
    id: index + 1,
    buyerName: 'Ahmed Mohamed',
    buyerAvatarUrl: null,
    lastMessage: 'Can you share more details about the item?',
    lastMessageTime: DateTime.now().subtract(Duration(minutes: index * 8)),
    unreadCount: index.isEven ? 2 : 0,
  ),
);
