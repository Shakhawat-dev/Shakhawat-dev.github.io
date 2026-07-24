import 'package:flutter/material.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/utils/launch_utils.dart';
import '../../../data/models/personal_info.dart';
import '../common/section_heading.dart';
import '../common/social_icon_button.dart';

class ContactFooterSection extends StatelessWidget {
  const ContactFooterSection({super.key, required this.personalInfo});

  final PersonalInfo personalInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Breakpoints.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          index: '06',
          eyebrow: 'Contact',
          title: "Let's build something together",
          subtitle: 'Have a project in mind, an open role, or just want to talk '
              'iOS architecture? My inbox is open.',
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _ContactCard(
              icon: Icons.email_outlined,
              label: 'Email',
              value: personalInfo.email,
              onTap: () => LaunchUtils.sendEmail(personalInfo.email),
            ),
            _ContactCard(
              icon: Icons.call_outlined,
              label: 'Phone',
              value: personalInfo.phone,
              onTap: () => LaunchUtils.call(personalInfo.phone),
            ),
            _ContactCard(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: personalInfo.location,
              onTap: null,
            ),
          ],
        ),
        const SizedBox(height: 48),
        Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25)),
        const SizedBox(height: 24),
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                '© ${DateTime.now().year} ${personalInfo.name}. All rights reserved.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (isMobile) const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: [
                SocialIconButton(
                  icon: Icons.code_rounded,
                  tooltip: 'GitHub',
                  onTap: () => LaunchUtils.openUrl(personalInfo.github),
                ),
                SocialIconButton(
                  icon: Icons.business_center_outlined,
                  tooltip: 'LinkedIn',
                  onTap: () => LaunchUtils.openUrl(personalInfo.linkedin),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Breakpoints.isMobile(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: isMobile ? double.infinity : 260,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: theme.colorScheme.secondary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
