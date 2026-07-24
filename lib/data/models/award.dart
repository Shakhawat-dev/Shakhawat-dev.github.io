/// A single award / certification line item.
class Award {
  const Award({required this.title, required this.location});

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );
  }

  final String title;
  final String location;
}
