import 'package:fam_assignment/config/constants.dart';
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
  }) {
    final type = DesignType.fromString(designType);
    Widget cardWidget;

    switch (type) {
      case DesignType.hc1:
        cardWidget = HC1SmallDisplayCard(card: card);
        break;

      case DesignType.hc3:
        cardWidget = HC3BigDisplayCard(card: card);
        break;

      case DesignType.hc5:
        cardWidget = HC5ImageCard(card: card);
        break;

      case DesignType.hc6:
        cardWidget = HC6SmallArrowCard(card: card);
        break;

      case DesignType.hc9:
        cardWidget = HC9DynamicWidthCard(card: card);
        break;

      case null:
        cardWidget = const SizedBox.shrink();
    }

    return cardWidget;
  }

  static Widget buildCardGroup(CardGroup cardGroup) {
    if (cardGroup.cards.isEmpty) {
      return const SizedBox.shrink();
    }

    final groupHeight = cardGroup.height?.toDouble();
    final designType = cardGroup.designType ?? '';
    final isHC9 = DesignType.fromString(designType) == DesignType.hc9;

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
          shrinkWrap: true,
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
        child: buildCard(card: cardGroup.cards[0], designType: designType),
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
                child: buildCard(card: card, designType: designType),
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  static List<Widget> buildAllCardGroups(
    List<CardGroup> cardGroups, [
    List<String> hiddenCardIds = const [],
  ]) {
    if (cardGroups.isEmpty) {
      return [const SizedBox.shrink()];
    }

    final sortedGroups = List<CardGroup>.from(cardGroups)
      ..sort((a, b) => (a.level ?? 0).compareTo(b.level ?? 0));

    final filteredGroups = sortedGroups
        .map((group) {
          final visibleCards = group.cards
              .where((card) => !hiddenCardIds.contains(card.id.toString()))
              .toList();

          return CardGroup(
            id: group.id,
            name: group.name,
            designType: group.designType,
            cards: visibleCards,
            isScrollable: group.isScrollable,
            height: group.height,
            level: group.level,
          );
        })
        .where((group) => group.cards.isNotEmpty)
        .toList();

    return filteredGroups.map((group) => buildCardGroup(group)).toList();
  }
}
