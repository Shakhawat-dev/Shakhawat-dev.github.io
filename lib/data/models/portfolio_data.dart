import 'award.dart';
import 'education_entry.dart';
import 'experience.dart';
import 'language_skill.dart';
import 'personal_info.dart';
import 'skill_group.dart';

/// Root aggregate for the entire site — the whole page tree is built from
/// one of these, which itself is parsed straight out of
/// `assets/data/portfolio.json`. To change the site's content, edit that
/// JSON file; no Dart changes are required.
class PortfolioData {
  const PortfolioData({
    required this.personalInfo,
    required this.skillGroups,
    required this.experience,
    required this.education,
    required this.training,
    required this.awards,
    required this.languages,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      personalInfo: PersonalInfo.fromJson(
        json['personalInfo'] as Map<String, dynamic>? ?? const {},
      ),
      skillGroups: (json['skillGroups'] as List<dynamic>? ?? const [])
          .map((e) => SkillGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      experience: (json['experience'] as List<dynamic>? ?? const [])
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      education: (json['education'] as List<dynamic>? ?? const [])
          .map((e) => EducationEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      training: (json['training'] as List<dynamic>? ?? const [])
          .map((e) => EducationEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      awards: (json['awards'] as List<dynamic>? ?? const [])
          .map((e) => Award.fromJson(e as Map<String, dynamic>))
          .toList(),
      languages: (json['languages'] as List<dynamic>? ?? const [])
          .map((e) => LanguageSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final PersonalInfo personalInfo;
  final List<SkillGroup> skillGroups;
  final List<Experience> experience;
  final List<EducationEntry> education;
  final List<EducationEntry> training;
  final List<Award> awards;
  final List<LanguageSkill> languages;
}
