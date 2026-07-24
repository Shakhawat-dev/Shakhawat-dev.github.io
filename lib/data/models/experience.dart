/// A single work-experience entry rendered in the timeline.
class Experience {
  const Experience({
    required this.company,
    required this.role,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.highlights,
    required this.projects,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      company: json['company'] as String? ?? '',
      role: json['role'] as String? ?? '',
      location: json['location'] as String? ?? '',
      startDate: DateTime.tryParse(json['startDate'] as String? ?? ''),
      endDate: json['endDate'] == null
          ? null
          : DateTime.tryParse(json['endDate'] as String),
      highlights: (json['highlights'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      projects: (json['projects'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  final String company;
  final String role;
  final String location;
  final DateTime? startDate;

  /// Null means "current" / present-day role.
  final DateTime? endDate;
  final List<String> highlights;
  final List<String> projects;

  bool get isCurrent => endDate == null;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _format(DateTime d) => '${_months[d.month - 1]} ${d.year}';

  /// e.g. "Mar 2021 – Present" or "Aug 2020 – Mar 2021".
  String get dateRange {
    final start = startDate == null ? '' : _format(startDate!);
    final end = isCurrent ? 'Present' : (endDate == null ? '' : _format(endDate!));
    return '$start – $end';
  }

  /// Approximate tenure, e.g. "4 yrs 4 mos".
  String get duration {
    if (startDate == null) return '';
    final end = endDate ?? DateTime.now();
    var totalMonths = (end.year - startDate!.year) * 12 + (end.month - startDate!.month);
    if (totalMonths < 0) totalMonths = 0;
    final years = totalMonths ~/ 12;
    final months = totalMonths % 12;
    final parts = <String>[];
    if (years > 0) parts.add('$years yr${years > 1 ? 's' : ''}');
    if (months > 0 || parts.isEmpty) parts.add('$months mo${months == 1 ? '' : 's'}');
    return parts.join(' ');
  }
}
