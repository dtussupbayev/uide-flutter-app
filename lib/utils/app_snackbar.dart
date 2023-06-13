import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';

class AppSnackBar {
  static SnackBar showErrorSnackBar(String message) {
    return SnackBar(
      backgroundColor: ProjectColors.kMediumGreen,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }
}

SnackBar appSnackbar = const SnackBar(
  backgroundColor: ProjectColors.kMediumGreen,
  content: Text(
    'Пароль или почта введены неправильно',
    style: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  duration: Duration(seconds: 6),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    ),
  ),
);
