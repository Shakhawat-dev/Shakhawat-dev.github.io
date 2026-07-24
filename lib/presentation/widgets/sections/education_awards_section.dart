import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/utils/launch_utils.dart';
import '../../../data/models/award.dart';
import '../../../data/models/education_entry.dart';
import '../common/section_heading.dart';

class EducationAwardsSection extends StatelessWidget {
  const EducationAwardsSection({
    super.key,
    required this.education,
    required this.training,
    required this.awards,
  });

  final List<EducationEntry> education;
  final List<EducationEntry> training;
  final List<Award> awards;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final combinedEducation = [...education, ...training];

    final educationColumn = _Column(
      title: 'Education & Training',
      icon: Icons.school_outlined,
      children: [
        for (final entry in combinedEducation) _EducationTile(entry: entry),
      ],
    );

    final awardsColumn = _Column(
      title: 'Awards & Certifications',
      icon: Icons.emoji_events_outlined,
      children: [
        for (final award in awards) _AwardTile(award: award),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          index: '04',
          eyebrow: 'Background',
          title: 'Education, training & recognition',
        ),
        const SizedBox(height: 32),
        if (isMobile)
          Column(
            children: [
              educationColumn,
              const SizedBox(height: 32),
              awardsColumn,
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: educationColumn),
              const SizedBox(width: 40),
              Expanded(child: awardsColumn),
            ],
          ),
      ],
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.title, required this.icon, required this.children});

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: theme.colorScheme.secondary, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: theme.textTheme.titleLarge)),
          ],
        ),
        const SizedBox(height: 18),
        ...children,
      ],
    );
  }
}

class _EducationTile extends StatelessWidget {
  const _EducationTile({required this.entry});

  final EducationEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.degree, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            InkWell(
              onTap: entry.url.isEmpty ? null : () => LaunchUtils.openUrl(entry.url),
              child: Text(
                entry.institution,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  decoration: entry.url.isEmpty ? null : TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              [entry.yearRange, entry.location].where((s) => s.isNotEmpty).join(' · '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 350.ms);
  }
}

class _AwardTile extends StatelessWidget {
  const _AwardTile({required this.award});

  final Award award;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.workspace_premium_outlined, size: 18, color: theme.colorScheme.secondary),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(text: award.title),
                  if (award.location.isNotEmpty)
                    TextSpan(
                      text: ' — ${award.location}',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms);
  }
}
