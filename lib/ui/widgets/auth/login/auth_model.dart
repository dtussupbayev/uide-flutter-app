import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/data_provider/token_data_provider.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:http/http.dart' as http;
import 'package:uide/ui/widgets/app/main.dart';
import 'package:uide/utils/app_snackbar.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _tokenDataProvider = TokenDataProvider();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _showPassword = false;
  bool get showPassword => _showPassword;

  void setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  Future<void> auth(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    notifyListeners();

    String? token;
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: ProjectColors.kLightGreen,
          ));
        });

    http.Response? response = await _apiClient.auth(
      email: email,
      password: password,
      context: context,
    );
    final json = await jsonDecode(response!.body);

    if (response.statusCode == 200) {
      token = await json['token'] as String?;
      notifyListeners();

      _tokenDataProvider.setToken(token);
      _tokenDataProvider.setEmail(email);
      _tokenDataProvider.setPassword(password);
    } else {
      if (json['errorCode'] == 0) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar.showErrorSnackBar(
              'Пароль или почта введены неправильно',
            ),
          );
          Navigator.pop(context);
        }

        FocusManager.instance.primaryFocus?.unfocus();

        return notifyListeners();
      }
    }

    notifyListeners();

    await _tokenDataProvider.setToken(token);
    await _tokenDataProvider.setEmail(email);
    await _tokenDataProvider.setPassword(password);

    if (context.mounted) {
      RestartWidget.restartApp(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
          MainNavigationRouteNames.mainScreen, (route) => false);
    }
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: ProjectColors.kBlack,
          fontSize: 20),
      actionsOverflowButtonSpacing: 20,
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok')),
      ],
      content: const Text('Unknown error, please try again'),
    );
  }
}
