/// Basic profile / contact information shown in the hero and footer sections.
class PersonalInfo {
  const PersonalInfo({
    required this.name,
    required this.title,
    required this.phone,
    required this.email,
    required this.website,
    required this.github,
    required this.linkedin,
    required this.location,
    required this.summary,
    this.avatar,
    this.coverImage,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      website: json['website'] as String? ?? '',
      github: json['github'] as String? ?? '',
      linkedin: json['linkedin'] as String? ?? '',
      location: json['location'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      avatar: json['avatar'] as String?,
      coverImage: json['coverImage'] as String?,
    );
  }

  final String name;
  final String title;
  final String phone;
  final String email;
  final String website;
  final String github;
  final String linkedin;
  final String location;
  final String summary;
  final String? avatar;
  final String? coverImage;

  /// Compact initials used as an avatar fallback when no image is provided.
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    final letters = parts.take(2).map((p) => p[0].toUpperCase());
    return letters.join();
  }
}
