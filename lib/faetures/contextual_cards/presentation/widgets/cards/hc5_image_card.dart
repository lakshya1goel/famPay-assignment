import 'package:flutter/material.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/card_model.dart';

class HC5ImageCard extends StatelessWidget {
  final CardModel card;

  const HC5ImageCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    if (card.bgImage?.imageUrl == null) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final aspectRatio = card.bgImage?.aspectRatio ?? 2.0;
    final imageHeight = screenWidth / aspectRatio;

    return Container(
      width: screenWidth,
      height: imageHeight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          card.bgImage!.imageUrl!,
          fit: BoxFit.cover,
          width: screenWidth,
          height: imageHeight,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return Container(
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'Image not available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
