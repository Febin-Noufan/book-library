class Author {
  final String id;
  final String name;
  final DateTime birthdate;
  final String biography;

  Author({
    required this.id,
    required this.name,
    required this.birthdate,
    required this.biography,
  });


  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      birthdate: DateTime.parse(json['birthdate']),
      biography: json['biography'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthdate': birthdate.toIso8601String(),
      'biography': biography,
    };
  }
}
