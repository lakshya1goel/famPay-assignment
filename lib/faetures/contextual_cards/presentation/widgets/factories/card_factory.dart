import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/cards/hc1_small_display_card.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/cards/hc3_big_display_card.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/cards/hc5_image_card.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/cards/hc6_small_arrow_card.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/cards/hc9_dynamic_width_card.dart';
import 'package:flutter/material.dart';
import '../../../data/models/card_group_model.dart';
import '../../../data/models/card_model.dart';

class CardFactory {
  CardFactory._();

  static Widget buildCard({
    required CardModel card,
    required String designType,
    double? height,
  }) {
    Widget cardWidget;

    switch (designType.toUpperCase()) {
      case 'HC1':
        cardWidget = HC1SmallDisplayCard(card: card);
        break;

      case 'HC3':
        cardWidget = HC3BigDisplayCard(card: card);
        break;

      case 'HC5':
        cardWidget = HC5ImageCard(card: card);
        break;

      case 'HC6':
        cardWidget = HC6SmallArrowCard(card: card);
        break;

      case 'HC9':
        cardWidget = HC9DynamicWidthCard(card: card);
        break;

      default:
        cardWidget = _UnsupportedCardWidget(designType: designType);
    }

    return cardWidget;
  }

  static Widget buildCardGroup(CardGroup cardGroup) {
    if (cardGroup.cards.isEmpty) {
      return const SizedBox.shrink();
    }

    final groupHeight = cardGroup.height?.toDouble();
    final designType = cardGroup.designType ?? '';
    final isHC9 = designType.toUpperCase() == 'HC9';

    if (isHC9) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: SizedBox(
          height: groupHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cardGroup.cards.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return buildCard(
                card: cardGroup.cards[index],
                designType: designType,
                height: groupHeight,
              );
            },
          ),
        ),
      );
    }

    if (cardGroup.isScrollable) {
      return Container(
        height: groupHeight,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cardGroup.cards.length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return IntrinsicWidth(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
                child: buildCard(
                  card: cardGroup.cards[index],
                  designType: designType,
                  height: groupHeight,
                ),
              ),
            );
          },
        ),
      );
    }

    if (cardGroup.cards.length == 1) {
      return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: buildCard(
          card: cardGroup.cards[0],
          designType: designType,
          height: groupHeight,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: cardGroup.cards.asMap().entries.map((entry) {
            final index = entry.key;
            final card = entry.value;
            final isLast = index == cardGroup.cards.length - 1;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: isLast ? 0 : 12),
                child: buildCard(
                  card: card,
                  designType: designType,
                  height: groupHeight,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  static List<Widget> buildAllCardGroups(List<CardGroup> cardGroups) {
    if (cardGroups.isEmpty) {
      return [const SizedBox.shrink()];
    }

    final sortedGroups = List<CardGroup>.from(cardGroups)
      ..sort((a, b) => (a.level ?? 0).compareTo(b.level ?? 0));

    return sortedGroups.map((group) => buildCardGroup(group)).toList();
  }
}

class _UnsupportedCardWidget extends StatelessWidget {
  final String designType;
  const _UnsupportedCardWidget({required this.designType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange[700],
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Unsupported card type: $designType',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
