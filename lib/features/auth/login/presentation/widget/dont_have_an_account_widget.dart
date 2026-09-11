import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAccountWidget extends StatelessWidget {
  final VoidCallback signupOnTap;
  const DontHaveAccountWidget({super.key, required this.signupOnTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Don't have an account?" + ' ',
          style: TextFontStyle.headlinePoppins40014grey,
          children: [
            TextSpan(
              text: 'Sign Up',
              style: TextFontStyle.headlinePoppins40014grey.copyWith(
                color: AppColors.textColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = signupOnTap,
            ),
          ],
        ),
      ),
    );
  }
}
