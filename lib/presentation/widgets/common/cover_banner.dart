import 'package:flutter/material.dart';

/// Wide banner image shown behind the avatar in the hero profile header.
/// Falls back to a gradient panel (matching the brand accent) when the JSON
/// doesn't provide a `coverImage`, so the layout never breaks if that field
/// is left out.
class CoverBanner extends StatelessWidget {
  const CoverBanner({super.key, required this.imagePath, required this.height});

  final String? imagePath;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget fallback() => DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.85),
                theme.colorScheme.secondary.withValues(alpha: 0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: (imagePath == null || imagePath!.isEmpty)
            ? fallback()
            : Image.asset(
                imagePath!,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => fallback(),
              ),
      ),
    );
  }
}
