import 'package:cached_network_image/cached_network_image.dart';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopUserInfoWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  const TopUserInfoWidget({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 56.h,
            width: 56.w,
            placeholder: (context, url) =>
                Image.asset(AppImages.onboardingImage),
            errorWidget: (context, url, error) =>
                Image.asset(AppImages.onboardingImage),
            fit: BoxFit.cover,
          ),
        ),
        UIHelper.horizontalSpace(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextFontStyle.headlinePoppins60018),
              Text(
                "Ready for your next inspection?",
                style: TextFontStyle.headlinePoppins40014.copyWith(
                  color: AppColors.titleTextColor,
                ),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
