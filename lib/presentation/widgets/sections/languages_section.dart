import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../data/models/language_skill.dart';
import '../common/section_heading.dart';

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({super.key, required this.languages});

  final List<LanguageSkill> languages;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          index: '05',
          eyebrow: 'Languages',
          title: 'Languages I communicate in',
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            for (var i = 0; i < languages.length; i++)
              SizedBox(
                width: isMobile ? double.infinity : 320,
                child: _LanguageCard(language: languages[i], delayMs: i * 80),
              ),
          ],
        ),
      ],
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({required this.language, required this.delayMs});

  final LanguageSkill language;
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
          Row(
            children: [
              Flexible(
                child: Text(
                  language.name,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (language.isMotherTongue) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Mother tongue',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (language.levels.isNotEmpty) ...[
            const SizedBox(height: 14),
            for (final level in language.levels)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(level.key, style: theme.textTheme.bodySmall),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _cefrToFraction(level.value),
                          minHeight: 6,
                          backgroundColor:
                              theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation(theme.colorScheme.secondary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      level.value,
                      style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    ).animate(delay: Duration(milliseconds: delayMs)).fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  double _cefrToFraction(String level) {
    const order = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final index = order.indexOf(level.toUpperCase());
    if (index == -1) return 0;
    return (index + 1) / order.length;
  }
}
