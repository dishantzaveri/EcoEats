class Quote {
  // ! Add id field

  final int id;
  final String text;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Quote({
    required this.id,
    required this.text,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      text: json['quote'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': text,
      'date': date.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Quote copyWith({
    int? id,
    String? text,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Quote(id: $id, text: $text, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
