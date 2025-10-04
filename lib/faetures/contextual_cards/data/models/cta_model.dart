class CTA {
  final String? text;
  final String? bgColor;
  final String? url;
  final String? textColor;

  CTA({
    this.text,
    this.bgColor,
    this.url,
    this.textColor,
  });

  factory CTA.fromJson(Map<String, dynamic> j) => CTA(
        text: j['text'] ?? '',
        bgColor: j['bg_color'] ?? '',
        url: j['url'] ?? '',
        textColor: j['text_color'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'bg_color': bgColor,
        'url': url,
        'text_color': textColor,
      };
}