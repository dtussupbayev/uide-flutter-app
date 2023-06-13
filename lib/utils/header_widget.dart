import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';

class HeaderWidget extends StatelessWidget {
  final double height;
  const HeaderWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.only(top: 45.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Uide',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.normal,
                  color: ProjectColors.kWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
