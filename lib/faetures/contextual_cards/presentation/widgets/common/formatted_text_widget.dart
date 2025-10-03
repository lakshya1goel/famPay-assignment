import 'package:flutter/material.dart';
import 'package:fam_assignment/core/utils/color_utils.dart';
import 'package:fam_assignment/core/utils/text_style_utils.dart';
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
    final entities = formattedText!.entities;
    final spans = <TextSpan>[];

    for (int i = 0; i < entities.length; i++) {
      final entity = entities[i];

      spans.add(
        TextSpan(
          text: entity.text ?? '',
          style: TextStyle(
            color: ColorUtils.parseColor(entity.color),
            fontSize: entity.fontSize?.toDouble() ?? 16,
            fontWeight: TextStyleUtils.getFontWeight(entity.fontFamily),
            decoration: TextStyleUtils.getTextDecoration(entity.fontStyle),
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
}
