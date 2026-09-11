import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAnAccountWidget extends StatelessWidget {
  final VoidCallback loginOnTap;
  const HaveAnAccountWidget({super.key, required this.loginOnTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Already have an account?" + ' ',
          style: TextFontStyle.headlinePoppins40014grey,
          children: [
            TextSpan(
              text: 'Sign in',
              style: TextFontStyle.headlinePoppins60014.copyWith(
                color: AppColors.textColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = loginOnTap,
            ),
          ],
        ),
      ),
    );
  }
}
