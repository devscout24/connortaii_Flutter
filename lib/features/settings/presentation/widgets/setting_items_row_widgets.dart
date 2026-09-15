import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingItemsRowWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  const SettingItemsRowWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                UIHelper.horizontalSpace(12.w),
                Text(title, style: TextFontStyle.headlinePoppins40016),
              ],
            ),
            SvgPicture.asset(AppIcons.arrowLeftIcon),
          ],
        ),
      ),
    );
  }
}
