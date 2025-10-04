class GradientModel {
  final List<String> colors;
  final int angle;

  GradientModel({
    required this.colors,
    required this.angle,
  });

  factory GradientModel.fromJson(Map<String, dynamic> json) => GradientModel(
        colors: (json['colors'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        angle: (json['angle'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'colors': colors,
        'angle': angle,
      };
}