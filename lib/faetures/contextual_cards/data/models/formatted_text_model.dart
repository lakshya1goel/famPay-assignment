import 'package:fam_assignment/faetures/contextual_cards/data/models/entity_mode.dart';

class FormattedText {
  final String? text;
  final String? align;
  final List<Entity> entities;

  FormattedText({
    this.text,
    this.align,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) => FormattedText(
        text: json['text'] ?? '',
        align: json['align'] ?? '',
        entities: (json['entities'] as List<dynamic>?)
                ?.map((e) => Entity.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'align': align,
        'entities': entities.map((e) => e.toJson()).toList(),
      };
}