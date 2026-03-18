import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

/// Action card used on the seller home screen.
///
/// Renders a background [backgroundImage] asset covered by a translucent blue
/// overlay, a 2 px primary-color border, a drop-shadow, and a centred [label]
/// (optionally with a "+" icon).
class HomeActionCard extends StatelessWidget {
  const HomeActionCard({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundImage,
    this.showAddIcon = false,
    this.width,
  });

  final String label;
  final VoidCallback? onTap;
  final String? backgroundImage;
  final bool showAddIcon;
  final double? width;

  static const _overlay = Color.fromRGBO(2, 62, 138, 0.30);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: 148.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primaryColor, width: 2),
          // Shadow from design: 0 2px 2px rgba(0,0,0,0.25)
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        // ClipRRect keeps image + overlay inside the rounded border
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              if (backgroundImage != null)
                Image.asset(
                  backgroundImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) =>
                      const SizedBox.shrink(),
                ),
              // Blue tinted overlay
              Container(color: _overlay),
              // Centred label row
              Center(
                child: Builder(
                  builder: (context) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: TextStyles.bold22(context).copyWith(
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black26,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      if (showAddIcon) ...[
                        SizedBox(width: 2.w),
                        Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 40.sp,
                          shadows: const [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black26,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
