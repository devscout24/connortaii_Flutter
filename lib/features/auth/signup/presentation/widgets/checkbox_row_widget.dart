import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CheckboxRowWidget extends StatefulWidget {
  final VoidCallback termsOnTap;
  final VoidCallback privacyOnTap;
  const CheckboxRowWidget({
    super.key,
    required this.termsOnTap,
    required this.privacyOnTap,
  });

  @override
  State<CheckboxRowWidget> createState() => _CheckboxRowWidgetState();
}

class _CheckboxRowWidgetState extends State<CheckboxRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextFontStyle.headlinePoppins40014grey,
          children: [
            const TextSpan(
              text: "By starting my application, I agree to app's" + ' ',
            ),
            TextSpan(
              text: 'Terms of Service',
              recognizer: TapGestureRecognizer()..onTap = widget.termsOnTap,
              style: TextFontStyle.headlinePoppins60014.copyWith(
                color: AppColors.textColor,
              ),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              recognizer: TapGestureRecognizer()..onTap = widget.privacyOnTap,
              style: TextFontStyle.headlinePoppins60014.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
