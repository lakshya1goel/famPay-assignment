import 'package:flutter/material.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import '../../../data/models/card_model.dart';
import '../common/formatted_text_widget.dart';

class HC3BigDisplayCard extends StatelessWidget {
  final CardModel card;

  const HC3BigDisplayCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth - 40;
    final aspectRatio = card.bgImage?.aspectRatio ?? 1.0;
    final cardHeight = cardWidth / aspectRatio;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              if (card.bgImage?.imageUrl != null)
                Image.network(
                  card.bgImage!.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.error_outline, color: Colors.grey),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),

              // Content Overlay
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Formatted Title using common widget
                    FormattedTextWidget(
                      formattedText: card.formattedTitle,
                      fallbackText: card.title,
                      defaultStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // CTA Buttons
                    if (card.cta.isNotEmpty)
                      Row(
                        children: card.cta.map((cta) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorUtils.parseColor(
                                  cta.bgColor,
                                ),
                                foregroundColor:
                                    ColorUtils.parseColor(cta.textColor) !=
                                        Colors.transparent
                                    ? ColorUtils.parseColor(cta.textColor)
                                    : Colors.white,
                                shape: cta.isCircular == true
                                    ? const CircleBorder()
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side:
                                            cta.strokeWidth != null &&
                                                cta.strokeWidth! > 0
                                            ? BorderSide(
                                                width: cta.strokeWidth!
                                                    .toDouble(),
                                                color: Colors.white,
                                              )
                                            : BorderSide.none,
                                      ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                cta.text ?? 'Action',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
