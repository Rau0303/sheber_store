// profile_header.dart
import 'package:flutter/material.dart';
import 'package:sheber_market/models/users.dart';

class ProfileHeader extends StatelessWidget {
  final Users? user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
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
              backgroundImage: NetworkImage(
                user?.photo ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(user?.name ?? 'Имя пользователя', style: Theme.of(context).textTheme.bodyLarge),
                subtitle: Text(user?.phoneNumber ?? 'Номер телефона', style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
