import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnhancedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onActionPressed;
  final bool showAction;

  const EnhancedAppBar({
    super.key,
    required this.title,
    required this.onActionPressed,
    this.showAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
      actions: [
        if (showAction)
          IconButton(
            onPressed: onActionPressed,
            icon: const Icon(CupertinoIcons.delete), // Можно заменить на другой иконку или виджет
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
