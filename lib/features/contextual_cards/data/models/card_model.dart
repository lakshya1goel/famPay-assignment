import 'package:fam_assignment/features/contextual_cards/data/models/card_image_model.dart';
import 'package:fam_assignment/features/contextual_cards/data/models/cta_model.dart';
import 'package:fam_assignment/features/contextual_cards/data/models/formatted_text_model.dart';
import 'package:fam_assignment/features/contextual_cards/data/models/gradient_model.dart';

class CardModel {
  final int id;
  final String? name;
  final String? title;
  final FormattedText? formattedTitle;
  final String? description;
  final FormattedText? formattedDescription;
  final CardImage? icon;
  final CardImage? bgImage;
  final String? bgColor;
  final GradientModel? bgGradient;
  final String? url;
  final List<CTA> cta;

  CardModel({
    required this.id,
    this.name,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.icon,
    this.bgImage,
    this.bgColor,
    this.bgGradient,
    this.url,
    required this.cta,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        title: json['title'] ?? '',
        formattedTitle: json['formatted_title'] != null
            ? FormattedText.fromJson(json['formatted_title'])
            : null,
        description: json['description'] ?? '',
        formattedDescription: json['formatted_description'] != null
            ? FormattedText.fromJson(json['formatted_description'])
            : null,
        icon: json['icon'] != null ? CardImage.fromJson(json['icon']) : null,
        bgImage: json['bg_image'] != null ? CardImage.fromJson(json['bg_image']) : null,
        bgColor: json['bg_color'] ?? '',
        bgGradient: json['bg_gradient'] != null
            ? GradientModel.fromJson(json['bg_gradient'])
            : null,
        url: json['url'] ?? '',
        cta: (json['cta'] as List<dynamic>?)
                ?.map((e) => CTA.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'formatted_title': formattedTitle?.toJson(),
        'description': description,
        'formatted_description': formattedDescription?.toJson(),
        'icon': icon?.toJson(),
        'bg_image': bgImage?.toJson(),
        'bg_color': bgColor,
        'bg_gradient': bgGradient?.toJson(),
        'url': url,
        'cta': cta.map((c) => c.toJson()).toList(),
      };
}