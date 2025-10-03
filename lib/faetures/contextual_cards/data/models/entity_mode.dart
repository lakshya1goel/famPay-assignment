class Entity {
  final String? text;
  final String? type;
  final String? color;
  final int? fontSize;
  final String? fontStyle;
  final String? fontFamily;
  final String? url;

  Entity({
    this.text,
    this.type,
    this.color,
    this.fontSize,
    this.fontStyle,
    this.fontFamily,
    this.url,
  });

  factory Entity.fromJson(Map<String, dynamic> j) => Entity(
        text: j['text'] as String?,
        type: j['type'] as String?,
        color: j['color'] as String?,
        fontSize:
            (j['font_size'] is num) ? (j['font_size'] as num).toInt() : null,
        fontStyle: j['font_style'] as String?,
        fontFamily: j['font_family'] as String?,
        url: j['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'type': type,
        'color': color,
        'font_size': fontSize,
        'font_style': fontStyle,
        'font_family': fontFamily,
        'url': url,
      };
}