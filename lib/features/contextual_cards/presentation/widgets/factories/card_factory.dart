import 'package:fam_assignment/config/constants.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/widgets/cards/hc1_small_display_card.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/widgets/cards/hc3_big_display_card.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/widgets/cards/hc5_image_card.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/widgets/cards/hc6_small_arrow_card.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/widgets/cards/hc9_dynamic_width_card.dart';
import 'package:flutter/material.dart';
import '../../../data/models/card_group_model.dart';
import '../../../data/models/card_model.dart';

class CardFactory {
  CardFactory._();

  // map of design types to their respective builders
  static final Map<String, Function(CardModel)> _builders = {};

  // initialize the builders
  static void initialize() {
    _builders[DesignType.hc1.value] = (card) => HC1SmallDisplayCard(card: card);
    _builders[DesignType.hc3.value] = (card) => HC3BigDisplayCard(card: card);
    _builders[DesignType.hc5.value] = (card) => HC5ImageCard(card: card);
    _builders[DesignType.hc6.value] = (card) => HC6SmallArrowCard(card: card);
    _builders[DesignType.hc9.value] = (card) => HC9DynamicWidthCard(card: card);
  }

  // build the card based on the design type
  static Widget buildCard({
    required CardModel card,
    required String designType,
  }) {
    final builder = _builders[designType.toUpperCase()];
  
    if (builder == null) {
      return const SizedBox.shrink();
    }

    return builder(card);
  }

  static Widget buildCardGroup(CardGroup cardGroup) {
    if (cardGroup.cards.isEmpty) {
      return const SizedBox.shrink();
    }

    final groupHeight = cardGroup.height?.toDouble();
    final designType = cardGroup.designType ?? '';
    final isHC9 = DesignType.fromString(designType) == DesignType.hc9;

    // build the card group for hc9 design type include height & neglect scrollable parameter
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

    // build cards with scrollable parameter (except HC9)
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

    // build cards without scrollable parameter with equal width (except HC9)
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

    // sort the card groups by level
    final sortedGroups = List<CardGroup>.from(cardGroups)
      ..sort((a, b) => (a.level ?? 0).compareTo(b.level ?? 0));

    // filter the card groups by hidden card ids
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
