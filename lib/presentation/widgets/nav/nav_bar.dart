import 'package:flutter/material.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../data/models/personal_info.dart';
import 'nav_item.dart';

/// Fixed header shown above the scrollable page. Desktop shows every nav
/// link inline; mobile collapses them into an overflow menu to keep the
/// header a single row at any width.
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
    required this.personalInfo,
    required this.items,
    required this.onNavTap,
    required this.isDark,
    required this.onToggleTheme,
  });

  final PersonalInfo personalInfo;
  final List<NavItem> items;
  final ValueChanged<GlobalKey> onNavTap;
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Breakpoints.isMobile(context) || Breakpoints.isTablet(context);

    return Material(
      elevation: 0,
      color: theme.scaffoldBackgroundColor.withValues(alpha: 0.92),
      child: Container(
        height: preferredSize.height,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 48),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
            ),
          ),
        ),
        // Centered at the same max width as the section content below, so
        // the logo/menu line up with the cover banner and section edges
        // instead of sitting further out on wide screens.
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Breakpoints.desktop),
            child: Row(
              children: [
                Flexible(child: _Logo(personalInfo: personalInfo)),
                const Spacer(),
                if (!isMobile) ...[
                  for (final item in items) _NavLink(item: item, onTap: onNavTap),
                  const SizedBox(width: 12),
                ],
                IconButton(
                  tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
                  onPressed: onToggleTheme,
                  icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                ),
                if (isMobile)
                  PopupMenuButton<GlobalKey>(
                    tooltip: 'Menu',
                    icon: const Icon(Icons.menu_rounded),
                    onSelected: onNavTap,
                    itemBuilder: (context) => [
                      for (final item in items)
                        PopupMenuItem(value: item.sectionKey, child: Text(item.label)),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.personalInfo});

  final PersonalInfo personalInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            personalInfo.initials,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            personalInfo.name,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.item, required this.onTap});

  final NavItem item;
  final ValueChanged<GlobalKey> onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(item.sectionKey),
      child: Text(item.label),
    );
  }
}
