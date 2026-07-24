/// A named category of skills, e.g. "iOS Development" -> [Swift, SwiftUI, ...].
class SkillGroup {
  const SkillGroup({required this.category, required this.items});

  factory SkillGroup.fromJson(Map<String, dynamic> json) {
    return SkillGroup(
      category: json['category'] as String? ?? '',
      items: (json['items'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  final String category;
  final List<String> items;
}
