// profile_options_list.dart
import 'package:flutter/material.dart';

class ProfileOptionsList extends StatelessWidget {
  final List<String> options;
  final ValueChanged<int> onOptionSelected;

  const ProfileOptionsList({
    super.key,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: ListView.separated(
        itemCount: options.length,
         separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(options[index], style: textTheme.headlineSmall),
            onTap: () => onOptionSelected(index),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
