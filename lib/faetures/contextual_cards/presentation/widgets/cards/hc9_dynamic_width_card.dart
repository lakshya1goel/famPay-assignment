import 'package:flutter/material.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import 'package:fam_assignment/core/utils/gradient_utils.dart';
import 'package:fam_assignment/core/services/deeplink_service.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/card_model.dart';

class HC9DynamicWidthCard extends StatelessWidget {
  final CardModel card;

  const HC9DynamicWidthCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final aspectRatio = card.bgImage?.aspectRatio ?? 1.0;
    final cardHeight = 195.0;
    final cardWidth = cardHeight * aspectRatio;

    return GestureDetector(
      onTap: () {
        if (card.url != null) {
          DeeplinkService.handleDeepLink(card.url);
        }
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient:
              card.bgGradient != null && card.bgGradient!.colors.isNotEmpty
              ? GradientUtils.createLinearGradient(
                  colors: card.bgGradient!.colors,
                  angle: card.bgGradient!.angle,
                  colorParser: ColorUtils.parseColor,
                )
              : null,
          color: card.bgGradient == null
              ? ColorUtils.parseColor(card.bgColor)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (card.bgImage?.imageUrl != null)
                Image.network(
                  card.bgImage!.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
