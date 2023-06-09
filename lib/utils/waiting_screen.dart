import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';

class ConnectionWaitingScreen extends StatelessWidget {
  const ConnectionWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: kMainBackgroundGradientDecoration,
      child: const SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          extendBody: true,
          body: Column(
            children: [
              SizedBox(height: 10),
            ],
          ),
          backgroundColor: ProjectColors.kTransparent,
        ),
      ),
    );
  }
}
