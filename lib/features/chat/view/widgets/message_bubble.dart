import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/chat/model/models/chat_models.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 0.78.sw),
        child: Column(
          crossAxisAlignment: isMine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: message.isPending ? 0.65 : 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 4.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isMine
                      ? AppColors.primaryColor
                      : const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(isMine ? 16.r : 4.r),
                    bottomRight: Radius.circular(isMine ? 4.r : 16.r),
                  ),
                ),
                child: Text(
                  message.content,
                  style: TextStyles.regular14(context).copyWith(
                    color: isMine ? Colors.white : Colors.black,
                    height: 1.35,
                  ),
                ),
              ),
            ),
            Text(
              _formatTime(context, message.sentAt),
              style: TextStyles.regular11(
                context,
              ).copyWith(color: const Color(0xFF999999)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(BuildContext context, DateTime dateTime) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat('h:mm a', locale).format(dateTime);
  }
}
