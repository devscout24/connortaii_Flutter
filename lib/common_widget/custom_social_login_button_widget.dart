import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomSocialLoginButtonWidget extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const CustomSocialLoginButtonWidget({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(image),
    );
  }
}
