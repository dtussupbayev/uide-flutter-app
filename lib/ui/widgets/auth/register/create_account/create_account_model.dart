import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';
import 'package:uide/utils/app_snackbar.dart';
import 'package:uide/utils/error_page.dart';

class CreateAccountModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String selectedSex = '';

  bool isLoading = false;

  bool _showPassword = false;
  bool get showPassword => _showPassword;

  void setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  Future<void> sendOtp(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final response = await _apiClient.sendOtp(
      body: {
        'email': emailController.text,
        'username': usernameController.text,
        'gender': selectedSex,
        'phoneNumber': phoneController.text,
      },
    );
    try {
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushNamed(
            context,
            MainNavigationRouteNames.otpFormScreen,
            arguments: UserAuthData(
                email: emailController.text,
                username: usernameController.text,
                sex: selectedSex,
                phone: phoneController.text),
          );
        }
      } else {
        final json = jsonDecode(response.body);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar.showErrorSnackBar(
              json['message'] as String,
            ),
          );
        }
      }
    } catch (error) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(
              error.toString(),
            ),
          ),
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }
}