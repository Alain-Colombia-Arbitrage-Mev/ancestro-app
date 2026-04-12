import 'package:flutter/material.dart';

class AppResponsive {
  final BuildContext context;
  late final double screenHeight;
  late final double screenWidth;

  AppResponsive(this.context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }

  /// Small: iPhone SE (667), Medium: iPhone 13 (844), Large: iPhone 14 Pro Max (932)
  bool get isSmall => screenHeight < 700;
  bool get isMedium => screenHeight >= 700 && screenHeight < 900;
  bool get isLarge => screenHeight >= 900;

  /// Adaptive vertical spacing — reduces on smaller screens
  double get spacingXS => isSmall ? 4 : 8;
  double get spacingSM => isSmall ? 8 : isMedium ? 12 : 16;
  double get spacingMD => isSmall ? 12 : isMedium ? 16 : 20;
  double get spacingLG => isSmall ? 16 : isMedium ? 20 : 25;
  double get spacingXL => isSmall ? 20 : isMedium ? 28 : 40;
  double get spacingXXL => isSmall ? 28 : isMedium ? 40 : 60;

  /// Adaptive font sizes
  double get titleSize => isSmall ? 20 : isMedium ? 23 : 26;
  double get subtitleSize => isSmall ? 17 : isMedium ? 19 : 21;
  double get bodySize => isSmall ? 13 : 14;

  /// Adaptive logo size
  double get logoWidth => isSmall ? 140 : isMedium ? 180 : 250;

  /// Adaptive section padding
  EdgeInsets get screenPadding => EdgeInsets.symmetric(
        horizontal: screenWidth < 400 ? 16 : 20,
      );
}
