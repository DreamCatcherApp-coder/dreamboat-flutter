import 'dart:convert';

class DreamEntry {
  final String id;
  final String text;
  final DateTime date;
  final String mood;
  final List<String>? secondaryMoods;
  final int? moodIntensity; // 1: Low, 2: Medium, 3: High
  final int? vividness; // 1: Vague, 2: Partial, 3: Clear
  final String interpretation;
  final String? title; // AI-generated dream title
  final bool isFavorite;

  DreamEntry({
    required this.id,
    required this.text,
    required this.date,
    required this.mood,
    this.secondaryMoods,
    this.moodIntensity,
    this.vividness,
    required this.interpretation,
    this.title,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'date': date.toIso8601String(),
      'mood': mood,
      'secondaryMoods': secondaryMoods,
      'moodIntensity': moodIntensity,
      'vividness': vividness,
      'interpretation': interpretation,
      'title': title,
      'isFavorite': isFavorite,
    };
  }

  factory DreamEntry.fromJson(Map<String, dynamic> json) {
    return DreamEntry(
      id: json['id'],
      text: json['text'],
      date: DateTime.parse(json['date']),
      mood: json['mood'],
      secondaryMoods: (json['secondaryMoods'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      moodIntensity: json['moodIntensity'],
      vividness: json['vividness'],
      interpretation: json['interpretation'] ?? '',
      title: json['title'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  DreamEntry copyWith({
    String? id,
    String? text,
    DateTime? date,
    String? mood,
    List<String>? secondaryMoods,
    int? moodIntensity,
    int? vividness,
    String? interpretation,
    String? title,
    bool? isFavorite,
  }) {
    return DreamEntry(
      id: id ?? this.id,
      text: text ?? this.text,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      secondaryMoods: secondaryMoods ?? this.secondaryMoods,
      moodIntensity: moodIntensity ?? this.moodIntensity,
      vividness: vividness ?? this.vividness,
      interpretation: interpretation ?? this.interpretation,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
