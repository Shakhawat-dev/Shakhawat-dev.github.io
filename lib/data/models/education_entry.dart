/// Shared shape for both "education" and "training" JSON sections.
class EducationEntry {
  const EducationEntry({
    required this.degree,
    required this.institution,
    required this.url,
    required this.location,
    required this.startDate,
    required this.endDate,
  });

  factory EducationEntry.fromJson(Map<String, dynamic> json) {
    return EducationEntry(
      degree: json['degree'] as String? ?? '',
      institution: json['institution'] as String? ?? '',
      url: json['url'] as String? ?? '',
      location: json['location'] as String? ?? '',
      startDate: DateTime.tryParse(json['startDate'] as String? ?? ''),
      endDate: DateTime.tryParse(json['endDate'] as String? ?? ''),
    );
  }

  final String degree;
  final String institution;
  final String url;
  final String location;
  final DateTime? startDate;
  final DateTime? endDate;

  String get yearRange {
    final start = startDate?.year.toString() ?? '';
    final end = endDate?.year.toString() ?? '';
    if (start.isEmpty && end.isEmpty) return '';
    if (start == end) return start;
    return '$start – $end';
  }
}
