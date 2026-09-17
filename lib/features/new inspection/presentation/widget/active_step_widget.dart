import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ActiveStepWidget extends StatelessWidget {
  const ActiveStepWidget({super.key, required this._activeStep});

  final int _activeStep;
  static const int stepCount = 3;

  static final List<String> steps = ['Step 1', 'Step 2', 'Step 3'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(stepCount, (index) {
            final isCompleted = index < _activeStep;
            final isActive = index == _activeStep;
            final isLast = index == stepCount - 1;

            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: isActive || isCompleted
                              ? SvgPicture.asset(AppIcons.activeStepIcon)
                              : SvgPicture.asset(AppIcons.inactiveStepIcon),
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            height: 2.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppColors.c000000
                                  : AppColors.grey300,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ),
                    ],
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    steps[index],
                    style: isActive || isCompleted
                        ? TextFontStyle.headlinePoppins40014.copyWith(
                            color: AppColors.c000000,
                          )
                        : TextFontStyle.headlinePoppins40014.copyWith(
                            color: AppColors.grey500,
                          ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// import 'package:connortaii_app/assets_helper/app_colors.dart';
// import 'package:connortaii_app/assets_helper/app_icons.dart';
// import 'package:connortaii_app/constants/text_font_style.dart';
// import 'package:connortaii_app/helpers/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// class ActiveStepWidget extends StatelessWidget {
//   const ActiveStepWidget({super.key, required this._activeStep});

//   final int _activeStep;
//   static const int stepCount = 3;

//   static final List<String> steps = ['Step 1', 'Step 2', 'Step 3'];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ...List.generate(stepCount, (index) {
//             final isCompleted = index < _activeStep;
//             final isActive = index == _activeStep;
//             final isLast = index == stepCount - 1;

//             return Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: SizedBox(
//                             width: 18.w,
//                             height: 18.w,
//                             child: isActive || isCompleted
//                                 ? SvgPicture.asset(AppIcons.activeStepIcon)
//                                 : SvgPicture.asset(AppIcons.inactiveStepIcon),
//                           ),
//                         ),
//                       ),
//                       if (!isLast)
//                         Expanded(
//                           child: Container(
//                             height: 2.h,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: isCompleted
//                                   ? AppColors.c000000
//                                   : AppColors.grey300,
//                               borderRadius: BorderRadius.circular(2.r),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   UIHelper.verticalSpace(8.h),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       steps[index],
//                       style: isActive || isCompleted
//                           ? TextFontStyle.headlinePoppins40014.copyWith(
//                               color: AppColors.c000000,
//                             )
//                           : TextFontStyle.headlinePoppins40014.copyWith(
//                               color: AppColors.grey500,
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
