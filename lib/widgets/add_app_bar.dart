import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddAppBar({
    super.key,
    required this.onActionPressed,
    required this.text
  });

  final  Function() onActionPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await onActionPressed();
          },
          icon: const Icon(CupertinoIcons.add),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
