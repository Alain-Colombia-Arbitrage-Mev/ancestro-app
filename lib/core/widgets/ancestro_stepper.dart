import 'package:flutter/material.dart';
import '../design/app_colors.dart';

class AncestroStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const AncestroStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return Container(
          width: isActive ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.surfaceBorder,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
