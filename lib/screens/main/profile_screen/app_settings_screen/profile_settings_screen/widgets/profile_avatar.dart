import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/profile_settings_screen/profile_settings_screen_logic.dart';

class ProfileAvatar extends StatelessWidget {
  final ProfileSettingsLogic logic;
  final Size screenSize;

  const ProfileAvatar({super.key, 
    required this.logic,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          await logic.pickImage();
          (context as Element).markNeedsBuild(); // Обновление виджета
        },
        child: CircleAvatar(
          radius: screenSize.height * 0.07,
          backgroundImage: logic.file != null
              ? FileImage(logic.file!)
              : null,
          backgroundColor: Colors.grey,
          child: logic.file == null
              ? Icon(Icons.person, size: screenSize.height * 0.1)
              : null,
        ),
      ),
    );
  }
}
