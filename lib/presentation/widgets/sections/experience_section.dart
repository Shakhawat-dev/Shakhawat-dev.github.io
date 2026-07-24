import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../data/models/experience.dart';
import '../common/section_heading.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.experience});

  final List<Experience> experience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          index: '03',
          eyebrow: 'Experience',
          title: "Where I've worked",
        ),
        const SizedBox(height: 32),
        for (var i = 0; i < experience.length; i++)
          _TimelineTile(
            item: experience[i],
            isLast: i == experience.length - 1,
            delayMs: i * 80,
          ),
      ],
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({
    required this.item,
    required this.isLast,
    required this.delayMs,
  });

  final Experience item;
  final bool isLast;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Breakpoints.isMobile(context);
    final rail = SizedBox(
      width: 28,
      child: Column(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.isCurrent ? theme.colorScheme.secondary : Colors.transparent,
              border: Border.all(color: theme.colorScheme.secondary, width: 2),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
        ],
      ),
    );

    final card = Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 28, left: isMobile ? 16 : 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 6,
              children: [
                Text(item.role, style: theme.textTheme.titleLarge),
                if (item.isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Current',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              item.company,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 16,
              runSpacing: 4,
              children: [
                _MetaChip(icon: Icons.calendar_today_outlined, label: item.dateRange),
                if (item.duration.isNotEmpty)
                  _MetaChip(icon: Icons.timelapse_outlined, label: item.duration),
                if (item.location.isNotEmpty)
                  _MetaChip(icon: Icons.location_on_outlined, label: item.location),
              ],
            ),
            const SizedBox(height: 16),
            for (final point in item.highlights)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        point,
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            if (item.projects.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final project in item.projects)
                    Chip(label: Text(project), visualDensity: VisualDensity.compact),
                ],
              ),
            ],
          ],
        ),
      ),
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rail,
          Expanded(child: card),
        ],
      ),
    ).animate(delay: Duration(milliseconds: delayMs)).fadeIn(duration: 400.ms).slideX(begin: 0.04, end: 0);
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface.withValues(alpha: 0.6);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 5),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: color)),
      ],
    );
  }
}
