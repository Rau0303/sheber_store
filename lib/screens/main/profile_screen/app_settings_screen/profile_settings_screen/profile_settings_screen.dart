import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/profile_settings_screen/profile_settings_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/profile_settings_screen/widgets/name_text_field.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/profile_settings_screen/widgets/phone_text_field.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/profile_settings_screen/widgets/profile_avatar.dart';
import 'package:sheber_market/widgets/default_app_bar.dart';
import 'package:sheber_market/widgets/save_button.dart';


class ProfileSettingsScreen extends StatefulWidget {
  static String route() => '/profile-settings'; // Укажите свой маршрут

  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  late ProfileSettingsLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = ProfileSettingsLogic();
  }

  @override
  void dispose() {
    _logic.nameController.dispose();
    _logic.phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const DefaultAppBar( text: 'Настройки профиля'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.02,
          vertical: screenSize.height * 0.02,
        ),
        child: Column(
          children: [
            ProfileAvatar(
              logic: _logic,
              screenSize: screenSize,
            ),
            SizedBox(height: screenSize.height * 0.03),
            NameTextField(controller: _logic.nameController),
            SizedBox(height: screenSize.height * 0.02),
            PhoneTextField(controller: _logic.phoneController),
            SizedBox(height: screenSize.height * 0.03),
            Savebutton(
              onPressed: ()async{
                  await _logic.saveProfile();
              }, text: 'Сохранить')
          ],
        ),
      ),
    );
  }
}

