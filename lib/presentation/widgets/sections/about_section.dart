import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../data/models/experience.dart';
import '../common/section_heading.dart';

/// Quick "about me" strip with a few headline stats derived from the JSON
/// data (years of experience, roles held, projects shipped) rather than
/// being hand-maintained numbers that can drift out of date.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.experience});

  final List<Experience> experience;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    final totalMonths = experience.fold<int>(0, (sum, e) {
      if (e.startDate == null) return sum;
      final end = e.endDate ?? DateTime.now();
      final months = (end.year - e.startDate!.year) * 12 + (end.month - e.startDate!.month);
      return sum + (months < 0 ? 0 : months);
    });
    final years = (totalMonths / 12).floor();
    final projectCount = experience.expand((e) => e.projects).toSet().length;

    final stats = [
      _Stat(value: '$years+', label: 'Years of experience'),
      _Stat(value: '${experience.length}', label: 'Companies'),
      _Stat(value: '$projectCount+', label: 'Apps shipped'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          index: '01',
          eyebrow: 'About',
          title: 'Building reliable mobile experiences, end to end',
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: isMobile ? 24 : 40,
          runSpacing: 24,
          children: [
            for (final stat in stats)
              SizedBox(
                width: isMobile ? double.infinity : 220,
                child: _StatTile(stat: stat),
              ),
          ],
        ),
      ],
    );
  }
}

class _Stat {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});
  final _Stat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stat.value,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(stat.label, style: theme.textTheme.bodyMedium),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }
}
