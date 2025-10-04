import 'package:fam_assignment/faetures/contextual_cards/data/models/card_model.dart';

class CardGroup {
  final int id;
  final String? name;
  final String? designType;
  final List<CardModel> cards;
  final bool isScrollable;
  final int? height;
  final int? level;

  CardGroup({
    required this.id,
    this.name,
    this.designType,
    required this.cards,
    required this.isScrollable,
    this.height,
    this.level,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) => CardGroup(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        designType: json['design_type'] ?? '',
        cards: (json['cards'] as List<dynamic>?)
                ?.map((e) => CardModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        isScrollable: json['is_scrollable'] ?? false,
        height: json['height'] ?? 0,
        level: json['level'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'design_type': designType,
        'cards': cards.map((c) => c.toJson()).toList(),
        'is_scrollable': isScrollable,
        'height': height,
        'level': level,
      };
}