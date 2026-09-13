import 'package:cached_network_image/cached_network_image.dart';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/home/presentation/widgets/no_inspection_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/recent_inspection_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/starts_inspection_container_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/top_user_info_widget.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 52.h,
          left: 12.w,
          right: 12.w,
          bottom: 12.h,
        ),
        child: Column(
          children: [
            TopUserInfoWidget(
              imageUrl:
                  'https://img.magnific.com/free-psd/3d-illustration-with-online-avatar_23-2151303097.jpg?semt=ais_hybrid&w=740&q=80',
              name: 'John Carry',
            ),
            UIHelper.verticalSpace(22.h),
            StartInspectionContainerWidget(onTap: () {}),
            UIHelper.verticalSpace(22.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Inspections',
                  style: TextFontStyle.headlinePoppins50018,
                ),
                Text('View All', style: TextFontStyle.headlinePoppins50014),
              ],
            ),
            UIHelper.verticalSpace(12.h),
            RecentInspectionWidget(
              title: '12 Queen Street',
              status: 'In Progress',
              address: 'Auckland CBD',
              date: '29 Aug 2026',
              sectionCompleteValue: '1',
              onTap: () {},
            ),
            UIHelper.verticalSpace(20.h),
            NoInspectionWidget(),
          ],
        ),
      ),
    );
  }
}
