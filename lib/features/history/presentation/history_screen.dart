import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/home/presentation/widgets/recent_inspection_widget.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  RecentInspectionWidget(
                    title: '12 Queen Street',
                    status: 'In Progress',
                    address: 'Auckland CBD',
                    date: '29 Aug 2026',
                    sectionCompleteValue: '1',
                    onTap: () {},
                  ),

                  Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'title',
                                style: TextFontStyle.headlinePoppins50016,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.grey300,
                                  borderRadius: BorderRadius.circular(21.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  child: Text(
                                    'status',
                                    style: TextFontStyle.headlinePoppins50016,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'address',
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
                                'date',
                                style: TextFontStyle.headlinePoppins40014
                                    .copyWith(color: AppColors.grey500),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          UIHelper.customDivider(),
                          UIHelper.verticalSpace(16.h),
                          Text(
                            "1 / 10 Sections Complete",
                            style: TextFontStyle.headlinePoppins50016,
                          ),
                          UIHelper.verticalSpace(6.h),
                          LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.c000000,
                            value: 0.1,
                            minHeight: 5.h,
                          ),
                          UIHelper.verticalSpace(20.h),
                          CustomIconButton(
                            onTap: () {},
                            title: "Continue Inspection",
                            borderRadius: BorderRadius.circular(12.r),
                            image: AppIcons.inspectionIcon,
                            fillColor: AppColors.grey300,
                            textColor: AppColors.c000000,
                          ),
                        ],
                      ),
                    ),
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

// import 'package:connortaii_app/assets_helper/app_colors.dart';
// import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
// import 'package:connortaii_app/constants/text_font_style.dart';
// import 'package:connortaii_app/helpers/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBarWidget(title: 'History'),
//       body: Padding(
//         padding: EdgeInsets.all(12.sp),
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.grey300,
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(8.sp),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.cFFFFFF,
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 10.w,
//                                 vertical: 8.h,
//                               ),
//                               child: Text(
//                                 'In Progress',
//                                 style: TextFontStyle.headlinePoppins50018,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ),
//                         UIHelper.horizontalSpace(12.w),
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.cFFFFFF,
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 10.w,
//                                 vertical: 8.h,
//                               ),
//                               child: Text(
//                                 'Completed',
//                                 style: TextFontStyle.headlinePoppins50018,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
