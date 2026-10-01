import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/history/presentation/widgets/history_completed_widget.dart';
import 'package:connortaii_app/features/history/presentation/widgets/history_in_progress_widget.dart';
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
      appBar: CustomAppBarWidget(title: 'History', showLeadingIcon: false),
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

            UIHelper.verticalSpace(16.h),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HistoryInProgressWidget(
                    title: '12 Queen Street',
                    address: 'Auckland CBD',
                    date: '29 Aug 2026',
                    sectionCompleteValue: '3',
                    onTap: () {},
                  ),

                  ListView.builder(
                    itemCount: 15,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return HistoryCompletedWidget(
                        title: '18 Queen Street',
                        address: 'BDLand CBD',
                        date: '30 Aug 2026',
                        downloadInspectionOnTap: () {},
                        shareInspectionOnTap: () {},
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
