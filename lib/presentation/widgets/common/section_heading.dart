import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Consistent "eyebrow + title" heading used at the top of every section,
/// e.g. "02 · Experience" over "Where I've worked".
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.index,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  final String index;
  final String eyebrow;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              index,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 10),
            Container(height: 1, width: 32, color: theme.colorScheme.secondary),
            const SizedBox(width: 10),
            Text(
              eyebrow.toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(title, style: theme.textTheme.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: 560,
            child: Text(
              subtitle!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08, end: 0);
  }
}
