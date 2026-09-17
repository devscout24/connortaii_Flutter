import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/history/presentation/history_screen.dart';
import 'package:connortaii_app/features/home/presentation/home_screen.dart';
import 'package:connortaii_app/features/settings/presentation/settings_screen.dart';
import 'package:connortaii_app/helpers/helper_methods.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavigationScreen extends StatefulWidget {
  final int? pageNum;

  const NavigationScreen({super.key, this.pageNum});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    SettingsScreen(),
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
      // ignore: deprecated_member_use
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final navItems = [
      _NavItemData(
        title: 'Home',
        selectedIcon: AppIcons.homeSelectedIcon,
        unselectedIcon: AppIcons.homeUnselectedIcon,
      ),
      _NavItemData(
        title: 'History',
        selectedIcon: AppIcons.historySelectedIcon,
        unselectedIcon: AppIcons.historyUnselectedIcon,
      ),
      _NavItemData(
        title: 'Settings',
        selectedIcon: AppIcons.settingSelectedIcon,
        unselectedIcon: AppIcons.settingUnselectedIcon,
      ),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      child: Container(
        height: 78.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.c000000,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(color: AppColors.grey200Color),
          boxShadow: [
            BoxShadow(
              color: AppColors.c000000.withAlpha(100),
              blurRadius: 12.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: List.generate(navItems.length, (index) {
            return Expanded(child: _buildNavItem(index, navItems[index]));
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, _NavItemData item) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cFFFFFF : Colors.transparent,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? item.selectedIcon : item.unselectedIcon,
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.c000000 : AppColors.cFFFFFF,
                BlendMode.srcIn,
              ),
            ),
            if (isSelected) ...[
              UIHelper.horizontalSpace(6.w),
              Text(
                item.title,
                style: TextFontStyle.headlinePoppins60012.copyWith(
                  color: AppColors.c000000,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  final String title;
  final String selectedIcon;
  final String unselectedIcon;

  const _NavItemData({
    required this.title,
    required this.selectedIcon,
    required this.unselectedIcon,
  });
}
