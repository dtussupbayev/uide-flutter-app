import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';
import 'package:uide/utils/app_snackbar.dart';

class CheckOtpModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final otpDigit1 = TextEditingController();
  final otpDigit2 = TextEditingController();
  final otpDigit3 = TextEditingController();
  final otpDigit4 = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> validateOtp(
      UserAuthData arguments, String otpCode, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final response = await _apiClient.checkOtp(
      body: {
        'email': arguments.email,
        'code': otpCode,
      },
    );
    isLoading = false;
    notifyListeners();

    if (response.statusCode == 200) {
      print(response.body);
      if (response.body == 'true') {
        if (context.mounted) {
          Navigator.pushNamed(
              context, MainNavigationRouteNames.createPasswordScreen,
              arguments: arguments);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar.showErrorSnackBar(
              'Вы ввели неправильный код',
            ),
          );
        }
      }
    } else {
      final json = jsonDecode(response.body);
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(json['message'] as String),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
