import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/chat/model/models/chat_models.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  final ConversationModel conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(conversation.buyerName);

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 12,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.secondaryColor,
              child: Text(
                initials,
                style: TextStyles.semiBold15(
                  context,
                ).copyWith(color: AppColors.primaryColor),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.buyerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.semiBold16(
                            context,
                          ).copyWith(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _formatTime(context, conversation.lastMessageTime),
                        style: TextStyles.regular12(
                          context,
                        ).copyWith(color: const Color(0xFF888888)),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage.isEmpty
                              ? '...'
                              : conversation.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.regular14(
                            context,
                          ).copyWith(color: const Color(0xFF777777)),
                        ),
                      ),
                      if (conversation.unreadCount > 0) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Text(
                            '${conversation.unreadCount}',
                            style: TextStyles.semiBold11(
                              context,
                            ).copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'C';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  String _formatTime(BuildContext context, DateTime dateTime) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = DateTime.now();
    final isToday =
        now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;

    if (isToday) {
      return DateFormat('h:mm a', locale).format(dateTime);
    }
    return DateFormat('d/M', locale).format(dateTime);
  }
}
