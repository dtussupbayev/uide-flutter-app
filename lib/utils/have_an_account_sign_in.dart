import 'package:flutter/material.dart';
import 'package:uide/navigation/main_navigation.dart';

import '../ui/theme/project_colors.dart';

class HaveAnAccountSignInWidget extends StatelessWidget {
  const HaveAnAccountSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'У вас есть аккаунт?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.pushNamed(
              context,
              MainNavigationRouteNames.authScreen,
            );
          },
          child: const Text(
            'Войти',
            style: TextStyle(
              fontSize: 16,
              color: ProjectColors.kDarkerMediumGreen,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
