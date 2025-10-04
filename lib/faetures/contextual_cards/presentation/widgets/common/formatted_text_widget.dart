import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import 'package:fam_assignment/core/utils/text_style_utils.dart';
import 'package:fam_assignment/core/services/deeplink_service.dart';
import '../../../data/models/formatted_text_model.dart';

class FormattedTextWidget extends StatelessWidget {
  final FormattedText? formattedText;
  final String? fallbackText;
  final TextStyle? defaultStyle;
  final int? maxLines;
  final TextOverflow? overflow;

  const FormattedTextWidget({
    super.key,
    this.formattedText,
    this.fallbackText,
    this.defaultStyle,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    if (formattedText == null || formattedText!.entities.isEmpty) {
      if (fallbackText == null || fallbackText!.isEmpty) {
        return const SizedBox.shrink();
      }
      return Text(
        fallbackText!,
        style: defaultStyle,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final textAlign = TextStyleUtils.getTextAlign(formattedText!.align);

    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(style: defaultStyle, children: _buildTextSpans()),
    );
  }

  List<TextSpan> _buildTextSpans() {
    final text = formattedText!.text;
    final entities = formattedText!.entities;
    final spans = <TextSpan>[];

    if (text == null || text.isEmpty) {
      for (int i = 0; i < entities.length; i++) {
        final entity = entities[i];
        spans.add(
          TextSpan(
            text: entity.text ?? '',
            style: TextStyle(
              color: ColorUtils.parseColor(entity.color),
              fontSize: entity.fontSize?.toDouble() ?? 14,
              fontWeight: TextStyleUtils.getFontWeight(entity.fontFamily),
              fontStyle: TextStyleUtils.getFontStyle(entity.fontStyle),
            ),
          ),
        );
        if (i < entities.length - 1) {
          spans.add(const TextSpan(text: '\n'));
        }
      }
      return spans;
    }

    final parts = text.split('{}');

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i], style: defaultStyle));
      }

      if (i < entities.length) {
        final entity = entities[i];
        final hasUrl = entity.url != null && entity.url!.isNotEmpty;

        spans.add(
          TextSpan(
            text: entity.text ?? '',
            style: TextStyle(
              color: ColorUtils.parseColor(entity.color),
              fontSize:
                  entity.fontSize?.toDouble() ?? defaultStyle?.fontSize ?? 14,
              fontWeight: TextStyleUtils.getFontWeight(entity.fontFamily),
              fontStyle: TextStyleUtils.getFontStyle(entity.fontStyle),
              decoration: hasUrl ? TextDecoration.underline : null,
            ),
            recognizer: hasUrl
                ? (TapGestureRecognizer()
                    ..onTap = () {
                      DeeplinkService.handleDeepLink(entity.url);
                    })
                : null,
          ),
        );
      }
    }

    return spans;
  }
}
