class CTA {
  final String? text;
  final String? type;
  final String? bgColor;
  final bool? isCircular;
  final bool? isSecondary;
  final int? strokeWidth;
  final String? url;
  final String? textColor;

  CTA({
    this.text,
    this.type,
    this.bgColor,
    this.isCircular,
    this.isSecondary,
    this.strokeWidth,
    this.url,
    this.textColor,
  });

  factory CTA.fromJson(Map<String, dynamic> j) => CTA(
        text: j['text'] as String?,
        type: j['type'] as String?,
        bgColor: j['bg_color'] as String?,
        isCircular: j['is_circular'] as bool?,
        isSecondary: j['is_secondary'] as bool?,
        strokeWidth: j['stroke_width'] is int ? j['stroke_width'] as int : null,
        url: j['url'] as String?,
        textColor: j['text_color'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'type': type,
        'bg_color': bgColor,
        'is_circular': isCircular,
        'is_secondary': isSecondary,
        'stroke_width': strokeWidth,
        'url': url,
        'text_color': textColor,
      };
}