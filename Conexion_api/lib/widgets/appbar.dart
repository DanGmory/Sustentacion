import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.appBarTheme.foregroundColor ??
              theme.colorScheme.onPrimary, // 👈 dinámico
        ),
      ),
      centerTitle: true,
      backgroundColor: theme.appBarTheme.backgroundColor ??
          theme.colorScheme.primary, // 👈 dinámico
      foregroundColor: theme.appBarTheme.foregroundColor ??
          theme.colorScheme.onPrimary, // 👈 dinámico
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? null
          : onMenuPressed != null
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  color: theme.appBarTheme.foregroundColor ??
                      theme.colorScheme.onPrimary,
                  onPressed: onMenuPressed,
                )
              : null,
      actions: actions,
    );
  }
}
