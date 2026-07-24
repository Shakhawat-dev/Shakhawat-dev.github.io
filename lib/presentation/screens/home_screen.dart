import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/portfolio_data.dart';
import '../../providers/portfolio_provider.dart';
import '../../providers/theme_provider.dart';
import '../widgets/nav/nav_bar.dart';
import '../widgets/nav/nav_item.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/contact_footer_section.dart';
import '../widgets/sections/education_awards_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/languages_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/common/section_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolio = context.watch<PortfolioProvider>();

    switch (portfolio.status) {
      case PortfolioStatus.loading:
        return const _LoadingView();
      case PortfolioStatus.error:
        return _ErrorView(onRetry: portfolio.reload);
      case PortfolioStatus.ready:
        return _PortfolioBody(data: portfolio.data!);
    }
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 48),
            const SizedBox(height: 16),
            const Text("Couldn't load portfolio.json"),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

/// Everything below this point only exists once `portfolio.json` has been
/// parsed successfully.
class _PortfolioBody extends StatefulWidget {
  const _PortfolioBody({required this.data});

  final PortfolioData data;

  @override
  State<_PortfolioBody> createState() => _PortfolioBodyState();
}

class _PortfolioBodyState extends State<_PortfolioBody> {
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _languagesKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final List<NavItem> _navItems = [
    NavItem(label: 'About', sectionKey: _aboutKey),
    NavItem(label: 'Skills', sectionKey: _skillsKey),
    NavItem(label: 'Experience', sectionKey: _experienceKey),
    NavItem(label: 'Education', sectionKey: _educationKey),
    NavItem(label: 'Languages', sectionKey: _languagesKey),
    NavItem(label: 'Contact', sectionKey: _contactKey),
  ];

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    final data = widget.data;

    return Scaffold(
      appBar: NavBar(
        personalInfo: data.personalInfo,
        items: _navItems,
        onNavTap: _scrollTo,
        isDark: themeProvider.isDark,
        onToggleTheme: themeProvider.toggle,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionShell(
              child: HeroSection(
                personalInfo: data.personalInfo,
                onContactTap: () => _scrollTo(_contactKey),
              ),
            ),
            SectionShell(
              sectionKey: _aboutKey,
              tinted: true,
              child: AboutSection(experience: data.experience),
            ),
            SectionShell(
              sectionKey: _skillsKey,
              child: SkillsSection(skillGroups: data.skillGroups),
            ),
            SectionShell(
              sectionKey: _experienceKey,
              tinted: true,
              child: ExperienceSection(experience: data.experience),
            ),
            SectionShell(
              sectionKey: _educationKey,
              child: EducationAwardsSection(
                education: data.education,
                training: data.training,
                awards: data.awards,
              ),
            ),
            SectionShell(
              sectionKey: _languagesKey,
              tinted: true,
              child: LanguagesSection(languages: data.languages),
            ),
            SectionShell(
              sectionKey: _contactKey,
              child: ContactFooterSection(personalInfo: data.personalInfo),
            ),
          ],
        ),
      ),
    );
  }
}
