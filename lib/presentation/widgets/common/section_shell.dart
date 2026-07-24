import 'package:flutter/material.dart';

import '../../../core/constants/breakpoints.dart';

/// Every top-level section (About, Skills, Experience, ...) wraps its
/// content in this shell so spacing, max content width, and background
/// alternation stay consistent without repeating the same padding math
/// everywhere.
class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.child,
    this.sectionKey,
    this.tinted = false,
    this.id,
  });

  final Widget child;
  final GlobalKey? sectionKey;
  final bool tinted;
  final String? id;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final theme = Theme.of(context);
    final tintColor = theme.brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.02)
        : Colors.black.withValues(alpha: 0.02);

    return Container(
      key: sectionKey,
      width: double.infinity,
      color: tinted ? tintColor : Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: isMobile ? 56 : 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Breakpoints.desktop),
          child: child,
        ),
      ),
    );
  }
}
