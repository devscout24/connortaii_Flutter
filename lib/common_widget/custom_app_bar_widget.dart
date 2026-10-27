import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? leadingOnTap;
  final VoidCallback? actionOnTap;
  final Widget? actionWidget;
  final bool showLeadingIcon;
  final double? toolbarHeight;

  const CustomAppBarWidget({
    super.key,
    this.title,
    this.leadingOnTap,
    this.actionWidget,
    this.showLeadingIcon = true,
    this.actionOnTap,
    this.toolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: AppColors.backgroundColor,
      toolbarHeight: toolbarHeight,
      leadingWidth: 55.w,
      backgroundColor: AppColors.cFFFFFF,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: showLeadingIcon
          ? GestureDetector(
              onTap: leadingOnTap ?? () => NavigationService.goBack,
              child: Padding(
                padding: EdgeInsets.all(6.sp),
                child: SvgPicture.asset(AppIcons.arrowBackIcon),
              ),
            )
          : null,
      title: Text(
        title ?? '',
        style: TextFontStyle.headlinePoppins60024,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        if (actionWidget != null)
          GestureDetector(
            onTap: actionOnTap,
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                padding: EdgeInsets.all(10.sp),
                child: actionWidget,
              ),
            ),
          ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: UIHelper.customDivider(color: AppColors.grey300),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((toolbarHeight ?? kToolbarHeight) + 1.h);
}
