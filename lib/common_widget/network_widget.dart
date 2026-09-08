import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double borderRadius;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius = 150,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = height ?? 50.h;
    final double imageWidth = width ?? 50.w;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          AppImages.logo,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.logo,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
