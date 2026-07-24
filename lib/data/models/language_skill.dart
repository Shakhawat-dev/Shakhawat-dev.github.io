/// CEFR-style language proficiency entry.
class LanguageSkill {
  const LanguageSkill({
    required this.name,
    required this.isMotherTongue,
    this.listening,
    this.reading,
    this.writing,
    this.spokenProduction,
    this.spokenInteraction,
  });

  factory LanguageSkill.fromJson(Map<String, dynamic> json) {
    return LanguageSkill(
      name: json['name'] as String? ?? '',
      isMotherTongue: json['isMotherTongue'] as bool? ?? false,
      listening: json['listening'] as String?,
      reading: json['reading'] as String?,
      writing: json['writing'] as String?,
      spokenProduction: json['spokenProduction'] as String?,
      spokenInteraction: json['spokenInteraction'] as String?,
    );
  }

  final String name;
  final bool isMotherTongue;
  final String? listening;
  final String? reading;
  final String? writing;
  final String? spokenProduction;
  final String? spokenInteraction;

  /// CEFR levels in display order, skipping any that weren't provided.
  List<MapEntry<String, String>> get levels => [
        if (listening != null) MapEntry('Listening', listening!),
        if (reading != null) MapEntry('Reading', reading!),
        if (writing != null) MapEntry('Writing', writing!),
        if (spokenProduction != null) MapEntry('Spoken Production', spokenProduction!),
        if (spokenInteraction != null) MapEntry('Spoken Interaction', spokenInteraction!),
      ];
}
