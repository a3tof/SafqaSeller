import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safqaseller/core/utils/app_images.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/app/view_model/app_view_model.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.subtitle,
    required this.title,
    this.showLanguageIcon = false,
  });

  final String image;
  final String subtitle;
  final Widget title;
  final bool showLanguageIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Column(
        children: [
          Align(
            alignment: Localizations.localeOf(context).languageCode == 'ar'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: BlocBuilder<AppViewModel, AppState>(
              builder: (context, state) {
                final appViewModel = AppViewModel.get(context);
                final isArabic =
                    appViewModel.currentLanguage == LanguageState.arabic ||
                        (appViewModel.currentLanguage == LanguageState.system &&
                            appViewModel.getLanguage() == 'ar');

                return InkWell(
                  onTap: () async {
                    if (appViewModel.currentLanguage == LanguageState.system) {
                      await appViewModel.selectLanguage(
                        LanguageState.english,
                      );
                    } else if (appViewModel.currentLanguage ==
                        LanguageState.english) {
                      await appViewModel.selectLanguage(LanguageState.arabic);
                    } else {
                      await appViewModel.selectLanguage(
                        LanguageState.english,
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.imagesIconoirLanguage,
                          width: 24.sp,
                          height: 24.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          isArabic ? 'AR' : 'EN',
                          style: TextStyles.semiBold13(
                            context,
                          ).copyWith(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Image.asset(
              Assets.imagesSAFQA,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(flex: 1),
          Flexible(
            flex: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(flex: 1),
          title,
          SizedBox(height: 8.h),
          Flexible(
            flex: 3,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyles.regular13(
                context,
              ).copyWith(color: Colors.black, height: 1.25),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
