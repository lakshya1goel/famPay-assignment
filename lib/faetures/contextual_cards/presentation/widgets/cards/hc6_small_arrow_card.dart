import 'package:flutter/material.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/card_model.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/common/formatted_text_widget.dart';

class HC6SmallArrowCard extends StatelessWidget {
  final CardModel card;

  const HC6SmallArrowCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: ColorUtils.parseColor(card.bgColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (card.icon?.imageUrl != null)
            Image.network(
              card.icon!.imageUrl!,
              width: 16,
              height: 16,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image, size: 16, color: Colors.grey);
              },
            ),

          const SizedBox(width: 15),

          Expanded(
            child: FormattedTextWidget(
              formattedText: card.formattedTitle,
              fallbackText: card.title,
              defaultStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
        ],
      ),
    );
  }
}
