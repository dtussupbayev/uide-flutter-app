import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';

import 'privacy_policy_data.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: kMainBackgroundGradientDecoration,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 150,
            centerTitle: true,
            elevation: 0,
            title: const Column(
              children: [
                Text(
                  'Политика',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Конфиденциальности',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: ProjectColors.kTransparent,
          ),
          extendBody: true,
          backgroundColor: ProjectColors.kTransparent,
          body: SizedBox(
            height: MediaQuery.of(context).size.height * 0.76,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: privacyPolicyData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        privacyPolicyData[index].title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        privacyPolicyData[index].content,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
