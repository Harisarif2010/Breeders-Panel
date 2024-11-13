
import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.borderColor,
    this.onTap,
    this.color = AppColors.primary,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.elevation = 0,
    this.textPadding = const EdgeInsets.symmetric(vertical: 15.0),
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontFamily: AppFont.montserratBold,
    ),
    super.key,
  });
  final VoidCallback? onTap;
  final String text;
  final Color? borderColor;
  final Color color;
  final double? height;
  final double? width;
  final BorderRadius borderRadius;
  final double elevation;
  final EdgeInsetsGeometry textPadding;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      child: InkWell(
        splashColor: Colors.black12,
        borderRadius: borderRadius,
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 1)
                : null,
            color: color,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: textPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}