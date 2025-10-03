import 'package:fam_assignment/faetures/contextual_cards/data/models/card_image_model.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/cta_model.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/formatted_text_model.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/gradient_model.dart';

class CardModel {
  final int id;
  final String? name;
  final String? slug;
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
  final bool? isDisabled;
  final bool? isShareable;
  final bool? isInternal;
  final double? iconSize;

  CardModel({
    required this.id,
    this.name,
    this.slug,
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
    this.isDisabled,
    this.isShareable,
    this.isInternal,
    this.iconSize,
  });

  factory CardModel.fromJson(Map<String, dynamic> j) => CardModel(
        id: j['id'] as int,
        name: j['name'] as String?,
        slug: j['slug'] as String?,
        title: j['title'] as String?,
        formattedTitle: j['formatted_title'] != null
            ? FormattedText.fromJson(j['formatted_title'])
            : null,
        description: j['description'] as String?,
        formattedDescription: j['formatted_description'] != null
            ? FormattedText.fromJson(j['formatted_description'])
            : null,
        icon: j['icon'] != null ? CardImage.fromJson(j['icon']) : null,
        bgImage: j['bg_image'] != null ? CardImage.fromJson(j['bg_image']) : null,
        bgColor: j['bg_color'] as String?,
        bgGradient: j['bg_gradient'] != null
            ? GradientModel.fromJson(j['bg_gradient'])
            : null,
        url: j['url'] as String?,
        cta: (j['cta'] as List<dynamic>?)
                ?.map((e) => CTA.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        isDisabled: j['is_disabled'] as bool?,
        isShareable: j['is_shareable'] as bool?,
        isInternal: j['is_internal'] as bool?,
        iconSize: (j['icon_size'] is num) ? (j['icon_size'] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
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
        'is_disabled': isDisabled,
        'is_shareable': isShareable,
        'is_internal': isInternal,
        'icon_size': iconSize,
      };
}