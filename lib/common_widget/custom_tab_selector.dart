import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomTabSelector({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTabItem(title: 'Log In', index: 0),
        _buildTabItem(title: 'Create Account', index: 1),
      ],
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextFontStyle.headlinePoppins60016.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: AppColors.cFFFFFF,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Container(
                height: 1.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.cFFFFFF
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
