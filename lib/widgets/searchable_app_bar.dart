import 'package:flutter/material.dart';

class SearchableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearch;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onSearchPressed;
  final VoidCallback onClearPressed;

  const SearchableAppBar({
    Key? key,
    required this.isSearch,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchPressed,
    required this.onClearPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      title: isSearch
          ? TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Поиск',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
                suffixIcon: IconButton(
                  onPressed: onClearPressed,
                  icon: Icon(Icons.clear, color: theme.colorScheme.onPrimary),
                ),
              ),
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
              onChanged: onSearchChanged,
            )
          : Text(
              'Главная',
              style: theme.textTheme.titleLarge,
            ),
      elevation: 0,
      actions: [
        if (!isSearch)
          IconButton(
            onPressed: onSearchPressed,
            icon: Icon(Icons.search, color: theme.colorScheme.onPrimary),
          ),
      ],
      automaticallyImplyLeading: false,
      backgroundColor: theme.appBarTheme.backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
