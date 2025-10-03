import 'package:fam_assignment/faetures/contextual_cards/data/models/home_section_model.dart';

abstract class HomeSectionState {}

class HomeSectionInitial extends HomeSectionState {}

class HomeSectionLoading extends HomeSectionState {}

class HomeSectionLoaded extends HomeSectionState {
  final List<HomeSection> homeSections;
  HomeSectionLoaded(this.homeSections);
}

class HomeSectionError extends HomeSectionState {
  final String message;
  HomeSectionError(this.message);
}

class HomeSectionEmpty extends HomeSectionState {}
