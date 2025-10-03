part of 'home_section_bloc.dart';

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
