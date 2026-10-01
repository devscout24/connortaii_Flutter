import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/features/settings/presentation/widgets/html_view_widget.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Privacy Policy',
        showLeadingIcon: true,
        leadingOnTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 48.h),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grey200Color,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: StreamBuilder(
                stream: privacyPolicyRXObj.dataFetcher,
                builder: (context, snapshot) {
                  final data = snapshot.data;

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
                    return const Center(child: Text("No privacy policy found"));
                  }
                  return HtmlViewWidget(input: '');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
