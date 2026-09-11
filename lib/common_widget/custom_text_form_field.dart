import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_font_style.dart';

// ignore_for_file: library_private_types_in_public_api

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? isPrefixIcon;
  final double borderRadius;
  final VoidCallback? onSuffixIconTap;
  final String? iconpath;
  final int maxline;
  final int? minLines;
  final bool readOnly;
  final bool isBorder;
  final Color fillColor;
  final Color? borderColor;
  // final Color? textInputColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final TextStyle? textInputStyle;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextStyle? labelStyle;
  final VoidCallback? onTap;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.borderRadius = 12, // Set to 10 pixels
    this.isPrefixIcon,
    this.iconpath,
    this.onSuffixIconTap,
    this.readOnly = false,
    this.maxline = 1,
    this.isBorder = false,
    this.fillColor = AppColors.lightGreenish,
    this.hintStyle,
    this.contentPadding,
    this.height,
    this.minLines,
    // this.textInputColor,
    this.textAlign,
    this.textInputStyle,
    this.focusBorderColor,
    this.cursorColor,
    this.textInputAction,
    this.borderColor,
    this.maxLength,
    this.labelStyle,
    this.onTap,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.controller?.addListener(() {
      setState(() {
        _hasText = widget.controller!.text.isNotEmpty;
      });
    });
    _focusNode.addListener(() {
      setState(() {
        //isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      style:
          widget.textInputStyle ??
          TextFontStyle.headlinePoppins40016grey.copyWith(
            color: AppColors.titleTextColor,
          ),
      maxLength: widget.maxLength,
      buildCounter:
          (_, {required currentLength, required isFocused, maxLength}) => null,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign ?? TextAlign.start,
      readOnly: widget.readOnly,
      maxLines: widget.maxline,
      minLines: widget.minLines,
      focusNode: _focusNode,
      //cursorColor: widget.cursorColor ?? AppColors.c000000,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.auto,
        // floatingLabelAlignment: FloatingLabelAlignment.center,
        filled: true,
        fillColor: widget.fillColor,
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: widget.labelStyle ?? TextFontStyle.headlinePoppins40016grey,
        hintStyle: widget.hintStyle ?? TextFontStyle.headlinePoppins40016grey,
        prefixIcon: widget.prefixIcon != null
            ? Padding(padding: EdgeInsets.all(14.sp), child: widget.prefixIcon)
            : null,
        suffixIcon: widget.suffixIcon,
        // suffixIcon: widget.suffixIcon != null
        // ? GestureDetector(
        // onTap: widget.onSuffixIconTap,
        // child: Padding(
        // padding: EdgeInsets.only(right: 16.w),
        // child: Icon(
        // widget.suffixIcon,
        // color: _isFocused
        // ? AppColors.allPrimaryColor
        // : AppColors.cffffff,
        // ),
        // ),
        // )
        // : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          // borderSide: BorderSide.none,
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.c000000,
            width: 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: _hasText
                ? (widget.borderColor ?? AppColors.c000000)
                : AppColors.c000000,
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: _hasText
                ? (widget.borderColor ?? AppColors.c000000)
                : AppColors.c000000,
            width: 1.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 3),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
      ),
    );
  }
}
