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

  factory CardImage.fromJson(Map<String, dynamic> j) => CardImage(
        imageType: j['image_type'] as String?,
        assetType: j['asset_type'] as String?,
        imageUrl: j['image_url'] as String?,
        aspectRatio: (j['aspect_ratio'] is num)
            ? (j['aspect_ratio'] as num).toDouble()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'image_type': imageType,
        'asset_type': assetType,
        'image_url': imageUrl,
        'aspect_ratio': aspectRatio,
      };
}