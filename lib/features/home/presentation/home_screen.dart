import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/home/presentation/widgets/no_inspection_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/recent_inspection_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/starts_inspection_container_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/top_user_info_widget.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProfileRXObj.getProfileRX();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 52.h,
            left: 12.w,
            right: 12.w,
            bottom: 12.h,
          ),
          child: Column(
            children: [
              StreamBuilder(
                stream: getProfileRXObj.dataFetcher,
                builder: (context, snapshot) {
                  final data = snapshot.data?.data;

                  if (snapshot.connectionState == ConnectionState.waiting &&
                      data == null) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const Center(
                        child: SpinKitPulse(
                          color: AppColors.buttonbgColor,
                          size: 70.0,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text(""));
                  }

                  return TopUserInfoWidget(
                    imageUrl: data?.avatar ?? '',
                    name: '${data?.firstName} ${data?.lastName}',
                  );
                },
              ),
              UIHelper.verticalSpace(22.h),
              StartInspectionContainerWidget(
                onTap: () {
                  NavigationService.navigateTo(Routes.newInspectionScreen);
                },
              ),
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
      ),
    );
  }
}
