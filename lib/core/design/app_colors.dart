import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceVariant = Color(0xFF1F1F1F);

  // Borders
  static const Color surfaceBorder = Color(0x1AFFFFFF);
  static const Color inputBorder = Color(0x0DFFFFFF);

  // Fills — matching .pen exactly
  static const Color inputFill = Color(0xFF141414);
  static const Color inputStroke = Color(0xFF1F1F1F);
  static const Color navFill = Color(0x33141414);

  // Labels
  static const Color labelText = Color(0xE5FFFFFF);
  static const Color placeholderText = Color(0xFF6C6C6C);

  // Primary (amber/gold)
  static const Color primary = Color(0xFFF8B03B);
  static const Color primaryTinted = Color(0x1AF0B535);
  static const Color primaryBorder = Color(0x4DF0B535);
  static const Color onPrimary = Color(0xFF0D0D0D);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB5B5B5);
  static const Color textTertiary = Color(0xFF9A9A9A);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color overlay = Color(0x73000000);
}
