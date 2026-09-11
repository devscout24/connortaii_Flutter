import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavigationScreen extends StatefulWidget {
  final int? pageNum;

  const NavigationScreen({super.key, this.pageNum});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    // const BuyerHomeScreen(),
    // const BuyerHomeScreen(),
    // const BuyerHomeScreen(),
    // const BuyerHomeScreen(),
    // const BuyerHomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageNum ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          body: _screens[_currentIndex],
          extendBody: true,
          bottomNavigationBar: Container(
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              // borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.grey200Color),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withAlpha(100),
                  blurRadius: 5.r,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildNavItem(
                    0,
                    _currentIndex == 0
                        ? AppIcons.splashLogo
                        : AppIcons.splashLogo,
                    'Home',
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    1,
                    _currentIndex == 1
                        ? AppIcons.splashLogo
                        : AppIcons.splashLogo,
                    'Saved',
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    2,
                    _currentIndex == 2
                        ? AppIcons.splashLogo
                        : AppIcons.splashLogo,
                    'Cart',
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    3,
                    _currentIndex == 3
                        ? AppIcons.splashLogo
                        : AppIcons.splashLogo,
                    'Messages',
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    4,
                    _currentIndex == 4
                        ? AppIcons.splashLogo
                        : AppIcons.splashLogo,
                    'Profile',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String title) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          Text(
            title,
            style: TextFontStyle.headlinePoppins60012.copyWith(
              color: isSelected ? AppColors.grey500 : AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
