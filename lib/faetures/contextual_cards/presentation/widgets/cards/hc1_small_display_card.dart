import 'package:flutter/material.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/card_model.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/common/formatted_text_widget.dart';

class HC1SmallDisplayCard extends StatelessWidget {
  final CardModel card;

  const HC1SmallDisplayCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: ColorUtils.parseColor(card.bgColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (card.icon?.imageUrl != null)
            Image.network(
              card.icon!.imageUrl!,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image, size: 16, color: Colors.grey);
              },
            ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FormattedTextWidget(
                  formattedText: card.formattedTitle,
                  fallbackText: card.title,
                  defaultStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                if (card.formattedDescription != null ||
                    card.description != null) ...[
                  const SizedBox(height: 2),
                  FormattedTextWidget(
                    formattedText: card.formattedDescription,
                    fallbackText: card.description,
                    defaultStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
