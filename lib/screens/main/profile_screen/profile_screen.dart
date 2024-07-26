import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen_logic.dart';
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
    logic = Provider.of<ProfileScreenLogic>(context); // Initialize logic
    if (logic.user == null) {
      logic.loadUserProfile(); // Load user profile if not already loaded
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

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
                  Container(
                    height: screenSize.height * 0.1,
                    width: screenSize.width - screenSize.width * 0.03,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: screenSize.height * 0.04,
                            backgroundImage: NetworkImage(logic.user?.photo ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(logic.user?.name ?? 'Имя пользователя', style: textTheme.bodyLarge),
                              subtitle: Text(logic.user?.phoneNumber ?? 'Номер телефона', style: textTheme.bodyLarge),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6, // Number of items
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            _getListElementTitle(index),
                            style: textTheme.headlineSmall,
                          ),
                          onTap: () => logic.navigateTo(index),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String _getListElementTitle(int index) {
    switch (index) {
      case 0:
        return 'О приложении';
      case 1:
        return 'Настройки аккаунта';
      case 2:
        return 'Мои покупки';
      case 3:
        return 'Настройки приложения';
      case 4:
        return 'Условия использования';
      case 5:
        return 'Выйти с аккаунта';
      default:
        return '';
    }
  }
}
