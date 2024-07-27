import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sheber_market/screens/main/profile_screen/profile_screen/profile_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen/widgets/profile_headrs.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen/widgets/profile_options_list.dart';
import 'package:sheber_market/widgets/enhanced_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileScreenLogic logic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logic = Provider.of<ProfileScreenLogic>(context);
    if (logic.user == null) {
      logic.loadUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: EnhancedAppBar(
        title: 'Профиль',
        onActionPressed: () {},
        showAction: false,
      ),
      body: logic.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.05,
                horizontal: screenSize.width * 0.03,
              ),
              child: Column(
                children: [
                  ProfileHeader(user: logic.user),
                  SizedBox(height: screenSize.height * 0.01),
                  ProfileOptionsList(
                    options: const [
                      'Настройки аккаунта',
                      'Мои покупки',
                      'Условия использования',
                      'Выйти с аккаунта',
                    ],
                    onOptionSelected: (index) => logic.navigateTo(context, index),
                  ),
                ],
              ),
            ),
    );
  }
}
