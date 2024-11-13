
import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';

class CustomLinearProgressBar extends StatelessWidget {
  final int maxSteps;
  final int currentStep;
  final Color progressColor;
  final Color backgroundColor;
  final String? text;

  const CustomLinearProgressBar({super.key, 
    required this.maxSteps,
    required this.currentStep,
    this.text,
    this.progressColor = AppColors.primary,
    this.backgroundColor = AppColors.grey,
  });

  @override
  Widget build(BuildContext context) {
    double progressHeight = MediaQuery.of(context).size.height * 0.015;
    double backgroundHeight = progressHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    double stepWidth = screenWidth / maxSteps;
    double progressWidth = currentStep * stepWidth / 1.5;

    return Center(
      child: SizedBox(
        height: progressHeight,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: backgroundHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(backgroundHeight / 2),
                ),
              ),
            ),
            Container(
              height: progressHeight,
              width: progressWidth,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(progressHeight / 2),
                  right: Radius.circular(progressHeight / 2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
