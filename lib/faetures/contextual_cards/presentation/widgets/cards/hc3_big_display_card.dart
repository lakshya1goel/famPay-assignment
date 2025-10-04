import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import 'package:fam_assignment/core/services/deeplink_service.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/bloc/home_section_bloc.dart';
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
    final cardHeight = 350.0;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: [
          Container(
            width: cardWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ActionButton(
                    icon: Image.asset('assets/remind.png'),
                    label: 'remind later',
                    onTap: () {
                      _controller.reverse();
                      context.read<HomeSectionBloc>().add(
                        RemindLaterCardEvent(widget.card.id.toString()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _ActionButton(
                    icon: Image.asset('assets/dismiss.png'),
                    label: 'dismiss now',
                    onTap: () {
                      _controller.reverse();
                      context.read<HomeSectionBloc>().add(
                        DismissCardEvent(widget.card.id.toString()),
                      );
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
                if (widget.card.url != null) {
                  DeeplinkService.handleDeepLink(widget.card.url);
                }
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
                                Icons.broken_image,
                                size: 48,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),

                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FormattedTextWidget(
                            formattedText: widget.card.formattedTitle,
                            fallbackText: widget.card.title,
                            defaultStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          if (widget.card.cta.isNotEmpty)
                            const SizedBox(height: 20),

                          if (widget.card.cta.isNotEmpty)
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: widget.card.cta.map((cta) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (cta.url != null) {
                                      DeeplinkService.handleDeepLink(cta.url);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorUtils.parseColor(
                                      cta.bgColor,
                                    ),
                                    foregroundColor:
                                        ColorUtils.parseColor(cta.textColor) !=
                                            Colors.transparent
                                        ? ColorUtils.parseColor(cta.textColor)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 14,
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    cta.text ?? 'Action',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
