import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.kDarkGreen,
      appBar: AppBar(
        title: const Text('Ошибка'),
        backgroundColor: ProjectColors.kLightGreen,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: ProjectColors.kMediumGreen,
                size: 64.0,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Упс! Что-то пошло не так',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: ProjectColors.kWhite,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                errorMessage,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ProjectColors.kLightGreen),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Повторить попытку',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
