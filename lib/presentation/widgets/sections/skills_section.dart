import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../data/models/skill_group.dart';
import '../common/section_heading.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.skillGroups});

  final List<SkillGroup> skillGroups;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final columns = isMobile ? 1 : (Breakpoints.isTablet(context) ? 2 : 3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          index: '02',
          eyebrow: 'Skills',
          title: 'Tools and technologies I work with',
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 20.0;
            final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (var i = 0; i < skillGroups.length; i++)
                  SizedBox(
                    width: columns == 1 ? double.infinity : width,
                    child: _SkillCard(group: skillGroups[i], delayMs: i * 60),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.group, required this.delayMs});

  final SkillGroup group;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            group.category,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in group.items)
                Chip(label: Text(item), visualDensity: VisualDensity.compact),
            ],
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delayMs))
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}
