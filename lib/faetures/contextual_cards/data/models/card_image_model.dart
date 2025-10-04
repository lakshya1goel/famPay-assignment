class CardImage {
  final String? imageType;
  final String? assetType;
  final String? imageUrl;
  final double? aspectRatio;

  CardImage({
    this.imageType,
    this.assetType,
    this.imageUrl,
    this.aspectRatio,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) => CardImage(
        imageType: json['image_type'] ?? '',
        assetType: json['asset_type'] ?? '',
        imageUrl: json['image_url'] ?? '',
        aspectRatio: (json['aspect_ratio'] is num)
            ? (json['aspect_ratio'] as num).toDouble()
            : 0.0,
      );

  Map<String, dynamic> toJson() => {
        'image_type': imageType,
        'asset_type': assetType,
        'image_url': imageUrl,
        'aspect_ratio': aspectRatio,
      };
}