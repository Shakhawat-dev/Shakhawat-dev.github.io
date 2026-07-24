import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/utils/launch_utils.dart';
import '../../../data/models/personal_info.dart';
import '../common/avatar.dart';
import '../common/cover_banner.dart';
import '../common/social_icon_button.dart';

/// Profile header: a wide cover photo with the avatar overlapping its
/// bottom edge (LinkedIn/GitHub-style), followed by name, title, summary
/// and calls to action — all centered so it reads well at any width.
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.personalInfo,
    required this.onContactTap,
  });

  final PersonalInfo personalInfo;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Breakpoints.isMobile(context);

    final coverHeight = isMobile ? 170.0 : 300.0;
    final avatarSize = isMobile ? 120.0 : 168.0;

    final profileHeader = Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        CoverBanner(imagePath: personalInfo.coverImage, height: coverHeight),
        Positioned(
          bottom: -avatarSize / 2,
          child: Avatar(personalInfo: personalInfo, size: avatarSize)
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.9, 0.9)),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Available for new opportunities',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Hi, I'm ${personalInfo.name}",
          textAlign: TextAlign.center,
          style: theme.textTheme.displayMedium?.copyWith(height: 1.1),
        ),
        const SizedBox(height: 8),
        Text(
          personalInfo.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: isMobile ? double.infinity : 620,
          child: Text(
            personalInfo.summary,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: onContactTap,
              icon: const Icon(Icons.mail_outline_rounded),
              label: const Text('Get in touch'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => LaunchUtils.openUrl(personalInfo.website),
              icon: const Icon(Icons.language_rounded),
              label: const Text('Visit website'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
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
            SocialIconButton(
              icon: Icons.email_outlined,
              tooltip: personalInfo.email,
              onTap: () => LaunchUtils.sendEmail(personalInfo.email),
            ),
            SocialIconButton(
              icon: Icons.call_outlined,
              tooltip: personalInfo.phone,
              onTap: () => LaunchUtils.call(personalInfo.phone),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.06, end: 0);

    return Padding(
      padding: EdgeInsets.only(top: isMobile ? 12 : 20, bottom: isMobile ? 24 : 40),
      child: Column(
        children: [
          profileHeader,
          SizedBox(height: avatarSize / 2 + 24),
          content,
        ],
      ),
    );
  }
}
