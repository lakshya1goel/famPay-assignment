import 'package:flutter/material.dart';
import 'package:fam_assignment/core/services/deeplink_service.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/card_model.dart';

class HC5ImageCard extends StatelessWidget {
  final CardModel card;

  const HC5ImageCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    if (card.bgImage?.imageUrl == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        if (card.url != null) {
          DeeplinkService.handleDeepLink(card.url);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          card.bgImage!.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
