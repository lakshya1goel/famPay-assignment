class Entity {
  final String? text;
  final String? color;
  final String? fontStyle;
  final String? url;
  final String? fontFamily;
  final int? fontSize;

  Entity({
    this.text,
    this.color,
    this.fontStyle,
    this.url,
    this.fontFamily,
    this.fontSize,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        text: json['text'] ?? '',
        color: json['color'] ?? '',
        fontStyle: json['font_style'] ?? '',
        url: json['url'] ?? '',
        fontFamily: json['font_family'] ?? '',
        fontSize: (json['font_size'] is num)
            ? (json['font_size'] as num).toInt()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'color': color,
        'font_style': fontStyle,
        'url': url,
        'font_family': fontFamily,
        'font_size': fontSize,
      };
}