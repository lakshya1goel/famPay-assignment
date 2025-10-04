import 'package:flutter/material.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import '../../../data/models/card_model.dart';
import '../common/formatted_text_widget.dart';

class HC3BigDisplayCard extends StatefulWidget {
  final CardModel card;

  const HC3BigDisplayCard({super.key, required this.card});

  @override
  State<HC3BigDisplayCard> createState() => _HC3BigDisplayCardState();
}

class _HC3BigDisplayCardState extends State<HC3BigDisplayCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.35, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleLongPress() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth - 40;
    final aspectRatio = widget.card.bgImage?.aspectRatio ?? 1.0;
    final cardHeight = cardWidth / aspectRatio;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ActionButton(
                    icon: Image.asset('assets/remind.png'),
                    label: 'remind later',
                    onTap: () {
                      _controller.reverse();
                    },
                  ),
                  const SizedBox(height: 12),
                  _ActionButton(
                    icon: Image.asset('assets/dismiss.png'),
                    label: 'dismiss now',
                    onTap: () {
                      _controller.reverse();
                    },
                  ),
                ],
              ),
            ),
          ),

          SlideTransition(
            position: _slideAnimation,
            child: GestureDetector(
              onLongPress: _handleLongPress,
              onTap: () {
                if (_controller.isCompleted) {
                  _controller.reverse();
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (widget.card.bgImage?.imageUrl != null)
                      Image.network(
                        widget.card.bgImage!.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
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
                            formattedText: widget.card.formattedTitle,
                            fallbackText: widget.card.title,
                            defaultStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          if (widget.card.cta.isNotEmpty)
                            Row(
                              children: widget.card.cta.map((cta) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorUtils.parseColor(
                                        cta.bgColor,
                                      ),
                                      foregroundColor:
                                          ColorUtils.parseColor(
                                                cta.textColor,
                                              ) !=
                                              Colors.transparent
                                          ? ColorUtils.parseColor(cta.textColor)
                                          : Colors.white,
                                      shape: cta.isCircular == true
                                          ? const CircleBorder()
                                          : RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
