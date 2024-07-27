import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/app_settings_screen/app_settings_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/app_settings_screen/widgets/settings_tile.dart';
import 'package:sheber_market/widgets/default_app_bar.dart';


class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final logic = AppSettingsLogic(context);

    return Scaffold(
      appBar: const DefaultAppBar(text: 'Настройки аккаунта'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.02,
          vertical: screenSize.height * 0.02,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(color: Colors.grey),
          itemCount: logic.elements.length,
          itemBuilder: (context, index) {
            final element = logic.elements[index];
            return SettingsTile(
              title: element['title'],
              onTap: () {
                logic.onTileTap(index);
              },
            );
          },
        ),
      ),
    );
  }
}
