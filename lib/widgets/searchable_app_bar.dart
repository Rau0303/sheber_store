import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearch;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onSearchPressed;
  final VoidCallback onClearPressed;
  final String appBarTitle;

  const SearchableAppBar({
    super.key,
    required this.isSearch,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchPressed,
    required this.onClearPressed,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: isSearch
          ? TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Поиск',
                hintStyle: theme.inputDecorationTheme.hintStyle,
                suffixIcon: IconButton(
                  onPressed: onClearPressed,
                  icon: const Icon(CupertinoIcons.clear, color: Colors.white),
                ),
              ),
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
              onChanged: onSearchChanged,
            )
          : Text(
              appBarTitle,
              style: theme.appBarTheme.titleTextStyle,
            ),
      actions: [
        if (!isSearch)
          IconButton(
            onPressed: onSearchPressed,
            icon: const Icon(CupertinoIcons.search, color: Colors.white),
          ),
      ],
      automaticallyImplyLeading: false,
      backgroundColor: theme.appBarTheme.backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
