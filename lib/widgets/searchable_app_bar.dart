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
                hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
                suffixIcon: IconButton(
                  onPressed: onClearPressed,
                  icon: Icon(Icons.clear, color: theme.colorScheme.onPrimary),
                ),
              ),
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
              onChanged: onSearchChanged,
            )
          :  Text(
              appBarTitle,
            ),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
