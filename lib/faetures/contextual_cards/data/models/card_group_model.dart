import 'package:fam_assignment/faetures/contextual_cards/data/models/card_model.dart';

class CardGroup {
  final int id;
  final String? name;
  final String? designType;
  final int? cardType;
  final List<CardModel> cards;
  final bool isScrollable;
  final int? height;
  final bool? isFullWidth;
  final String? slug;
  final int? level;

  CardGroup({
    required this.id,
    this.name,
    this.designType,
    this.cardType,
    required this.cards,
    required this.isScrollable,
    this.height,
    this.isFullWidth,
    this.slug,
    this.level,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) => CardGroup(
        id: json['id'] as int,
        name: json['name'] as String?,
        designType: json['design_type'] as String?,
        cardType: json['card_type'] as int?,
        cards: (json['cards'] as List<dynamic>?)
                ?.map((e) => CardModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        isScrollable: (json['is_scrollable'] as bool?) ?? false,
        height: json['height'] as int?,
        isFullWidth: json['is_full_width'] as bool?,
        slug: json['slug'] as String?,
        level: json['level'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'design_type': designType,
        'card_type': cardType,
        'cards': cards.map((c) => c.toJson()).toList(),
        'is_scrollable': isScrollable,
        'height': height,
        'is_full_width': isFullWidth,
        'slug': slug,
        'level': level,
      };
}