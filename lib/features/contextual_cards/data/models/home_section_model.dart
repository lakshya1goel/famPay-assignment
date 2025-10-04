import 'package:fam_assignment/features/contextual_cards/data/models/card_group_model.dart';

class HomeSection {
  final int id;
  final String? slug;
  final String? title;
  final String? description;
  final String? formattedTitle;
  final String? formattedDescription;
  final dynamic assets;
  final List<CardGroup> hcGroups;

  HomeSection({
    required this.id,
    this.slug,
    this.title,
    this.description,
    this.formattedTitle,
    this.formattedDescription,
    this.assets,
    required this.hcGroups,
  });

  factory HomeSection.fromJson(Map<String, dynamic> json) {
    return HomeSection(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      formattedTitle: json['formatted_title'] ?? '',
      formattedDescription: json['formatted_description'] ?? '',
      assets: json['assets'] ?? '',
      hcGroups: (json['hc_groups'] as List<dynamic>?)
              ?.map((e) => CardGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'title': title,
        'description': description,
        'formatted_title': formattedTitle,
        'formatted_description': formattedDescription,
        'assets': assets,
        'hc_groups': hcGroups.map((e) => e.toJson()).toList(),
      };

  static List<HomeSection> listFromJson(List<dynamic> data) =>
      data.map((e) => HomeSection.fromJson(e)).toList();
}