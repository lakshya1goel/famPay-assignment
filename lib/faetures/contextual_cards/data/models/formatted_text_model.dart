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

  factory FormattedText.fromJson(Map<String, dynamic> j) => FormattedText(
        text: j['text'] as String?,
        align: j['align'] as String?,
        entities: (j['entities'] as List<dynamic>?)
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