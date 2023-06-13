import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/data_provider/token_data_provider.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';
import 'package:uide/utils/app_snackbar.dart';

class CreatePasswordModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _tokenDataProvider = TokenDataProvider();
  final passwordController = TextEditingController();
  Response registerResponse = Response('0', 200);
  bool _showPassword = false;

  bool get getShowPassword => _showPassword;

  void setShowPassword(bool value) {
    _showPassword = value;
  }

  bool _isAuthProgress = false;

  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> register(BuildContext context, UserAuthData userAuthData) async {
    final password = passwordController.text;
    _isAuthProgress = true;
    notifyListeners();

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: ProjectColors.kLightGreen,
            ),
          );
        });

    try {
      Response? registerResponse = await _apiClient.register(
        userAuthData: userAuthData,
        password: password,
        context: context,
      );

      if (registerResponse!.statusCode == 200) {
        if (context.mounted) {
          Response? response = await _apiClient.auth(
            email: userAuthData.email!,
            password: password,
            context: context,
          );
          final json = await jsonDecode(response!.body);

          if (json['errorCode'] != null) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar.showErrorSnackBar(
                  "Error: ${json['message']}",
                ),
              );
            }
          }

          final token = await json['token'] as String?;

          _isAuthProgress = false;
          notifyListeners();
          if (token == null) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar.showErrorSnackBar(
                  'Пользователь не существует',
                ),
              );
            }

            if (context.mounted) Navigator.pop(context);
            FocusManager.instance.primaryFocus?.unfocus();

            return notifyListeners();
          }
          await _tokenDataProvider.setToken(token);

          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              MainNavigationRouteNames.mainScreen,
              (route) => false,
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar.showErrorSnackBar(
              registerResponse.body,
            ),
          );
        }

        FocusManager.instance.primaryFocus?.unfocus();

        return notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AppSnackBar.showErrorSnackBar(
          e.toString(),
        ),
      );

      FocusManager.instance.primaryFocus?.unfocus();

      return notifyListeners();
    }
  }
}
