import 'package:flutter/material.dart';

import '../../../data/models/personal_info.dart';

/// Renders the avatar image referenced in the JSON, falling back to a
/// gradient initials badge when no image asset has been added yet — so the
/// site still looks intentional before a profile photo is dropped in.
class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.personalInfo, this.size = 220});

  final PersonalInfo personalInfo;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarPath = personalInfo.avatar;

    Widget fallback() => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            personalInfo.initials,
            style: theme.textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        );

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: (avatarPath == null || avatarPath.isEmpty)
            ? fallback()
            : Image.asset(
                avatarPath,
                fit: BoxFit.cover,
                // The reference photo is portrait with the face in the
                // upper third — bias the crop upward so it isn't cut off.
                alignment: const Alignment(0, -0.6),
                errorBuilder: (context, error, stackTrace) => fallback(),
              ),
      ),
    );
  }
}
