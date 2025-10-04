part of 'home_section_bloc.dart';

abstract class HomeSectionState {}

class HomeSectionInitial extends HomeSectionState {}

class HomeSectionLoading extends HomeSectionState {}

class HomeSectionLoaded extends HomeSectionState {
  final List<HomeSection> homeSections;
  final List<String> hiddenCardIds;

  HomeSectionLoaded(this.homeSections, [this.hiddenCardIds = const []]);
}

class HomeSectionError extends HomeSectionState {
  final String message;
  HomeSectionError(this.message);
}

class HomeSectionEmpty extends HomeSectionState {}
