import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/home/presentation/widgets/recent_inspection_widget.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'History'),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                labelStyle: TextFontStyle.headlinePoppins50018,
                unselectedLabelStyle: TextFontStyle.headlinePoppins50018,
                tabs: const [
                  Tab(text: 'In Progress'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: RecentInspectionWidget(
                          title: '12 Queen Street',
                          status: 'In Progress',
                          address: 'Auckland CBD',
                          date: '29 Aug 2026',
                          sectionCompleteValue: '1',
                          onTap: () {},
                        ),
                      );
                    },
                  ),

                  ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.grey200Color,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '12 Queen Street',
                                      style: TextFontStyle.headlinePoppins50016,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey300,
                                        borderRadius: BorderRadius.circular(
                                          21.r,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 4.h,
                                        ),
                                        child: Text(
                                          'Completed',
                                          style: TextFontStyle
                                              .headlinePoppins50016,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Auckland CBD',
                                      style: TextFontStyle.headlinePoppins40014
                                          .copyWith(color: AppColors.grey500),
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    CircleAvatar(
                                      radius: 4.r,
                                      backgroundColor: AppColors.grey500,
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    Text(
                                      '29 Aug 2026',
                                      style: TextFontStyle.headlinePoppins40014
                                          .copyWith(color: AppColors.grey500),
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpace(20.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.grey300,
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                              horizontal: 10.w,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  AppIcons.inspectionIcon,
                                                ),
                                                UIHelper.horizontalSpace(4.w),
                                                Text(
                                                  'View Inspection',
                                                  style: TextFontStyle
                                                      .headlinePoppins50014
                                                      .copyWith(
                                                        color:
                                                            AppColors.grey800,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey300,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                          horizontal: 10.w,
                                        ),
                                        child: SvgPicture.asset(
                                          AppIcons.downloadIcon,
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey300,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                          horizontal: 10.w,
                                        ),
                                        child: SvgPicture.asset(
                                          AppIcons.shareIcon,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
