import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnectionNoneScreen extends StatelessWidget {
  final VoidCallback onRetry;
  const ConnectionNoneScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.wifi,
                color: ProjectColors.kWhite,
              ),
              const SizedBox(height: 30),
              const Text(
                'Упс!!',
                style: TextStyle(
                  color: ProjectColors.kWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                'Не найдено подключение к Интернету. Проверьте подключение или повторите попытку.',
                style: TextStyle(
                  color: ProjectColors.kWhite,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              Container(
                decoration: BoxDecoration(
                  color: ProjectColors.kMediumGreen,
                  border: Border.all(
                    color: ProjectColors.kBlack.withOpacity(0.1),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ProjectColors.kBlack.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    side: const BorderSide(
                      width: 0,
                      color: ProjectColors.kTransparent,
                    ),
                    foregroundColor: ProjectColors.kWhite,
                    backgroundColor: ProjectColors.kTransparent,
                  ),
                  onPressed: onRetry,
                  child: const Text('Повторить попытку'),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: ProjectColors.kDarkGreen,
    );
  }
}
