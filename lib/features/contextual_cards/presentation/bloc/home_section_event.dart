part of 'home_section_bloc.dart';

abstract class HomeSectionEvent {}

class FetchHomeSectionEvent extends HomeSectionEvent {}

class RefreshHomeSectionEvent extends HomeSectionEvent {}

class DismissCardEvent extends HomeSectionEvent {
  final String cardId;
  DismissCardEvent(this.cardId);
}

class RemindLaterCardEvent extends HomeSectionEvent {
  final String cardId;
  RemindLaterCardEvent(this.cardId);
}
