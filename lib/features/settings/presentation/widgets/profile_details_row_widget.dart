import 'package:cached_network_image/cached_network_image.dart';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsRowWidget extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  const ProfileDetailsRowWidget({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.settingsBgImage,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(top: 22.h, bottom: 22.h, left: 12.w),
            child: Row(
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
                      Text(
                        name,
                        style: TextFontStyle.headlinePoppins60018.copyWith(
                          color: AppColors.cFFFFFF,
                        ),
                      ),
                      Text(
                        email,
                        style: TextFontStyle.headlinePoppins40014.copyWith(
                          color: AppColors.cFFFFFF,
                        ),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
