import 'package:fam_assignment/features/contextual_cards/domain/usecases/home_section_usecase.dart';
import 'package:fam_assignment/features/contextual_cards/data/models/home_section_model.dart';
import 'package:fam_assignment/core/services/storage_service.dart';
import 'package:fam_assignment/core/errors/exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_section_event.dart';
part 'home_section_state.dart';

class HomeSectionBloc extends Bloc<HomeSectionEvent, HomeSectionState> {
  final HomeSectionUsecase homeSectionUsecase;
  final StorageService storageService;

  HomeSectionBloc(this.homeSectionUsecase, this.storageService)
    : super(HomeSectionInitial()) {

    // fetch home sections when the event is triggered
    on<FetchHomeSectionEvent>((event, emit) async {
      emit(HomeSectionLoading());
      try {
        await storageService.clearRemindLaterCards();

        // fetch home sections using usecase and emit the state
        final homeSection = await homeSectionUsecase();
        if (homeSection.isEmpty) {
          emit(HomeSectionEmpty());
        } else {
          final hiddenCardIds = storageService.getDismissedCards();
          // emit the state with the home sections and the list of ids of cards that are to be dismissed
          emit(HomeSectionLoaded(homeSection, hiddenCardIds));
        }
      } on ServerException catch (e) {
        emit(HomeSectionError('Server Error: ${e.message}'));
      } on CacheException catch (e) {
        emit(HomeSectionError('Storage Error: ${e.message}'));
      } on UnknownException catch (e) {
        emit(HomeSectionError('Unknown Error: ${e.message}'));
      } catch (e) {
        emit(HomeSectionError('Unexpected error: ${e.toString()}'));
      }
    });

    on<DismissCardEvent>((event, emit) async {
      // the data is fetched and loaded in the homesection state
      if (state is HomeSectionLoaded) {
        final currentState = state as HomeSectionLoaded;

        try {
          await storageService.dismissCard(event.cardId);

          final hiddenCardIds = [
            ...storageService.getDismissedCards(),
            ...storageService.getRemindLaterCards(),
          ];

          emit(HomeSectionLoaded(currentState.homeSections, hiddenCardIds));
        } on CacheException catch (e) {
          emit(HomeSectionError('Failed to dismiss card: ${e.message}'));
          emit(currentState);
        } catch (e) {
          emit(
            HomeSectionError(
              'Unexpected error dismissing card: ${e.toString()}',
            ),
          );
          emit(currentState);
        }
      }
    });

    on<RemindLaterCardEvent>((event, emit) async {
      if (state is HomeSectionLoaded) {
        final currentState = state as HomeSectionLoaded;

        try {
          await storageService.remindLater(event.cardId);

          final hiddenCardIds = [
            ...storageService.getDismissedCards(),
            ...storageService.getRemindLaterCards(),
          ];

          emit(HomeSectionLoaded(currentState.homeSections, hiddenCardIds));
        } on CacheException catch (e) {
          emit(HomeSectionError('Failed to set remind later: ${e.message}'));
          emit(currentState);
        } catch (e) {
          emit(
            HomeSectionError(
              'Unexpected error setting remind later: ${e.toString()}',
            ),
          );
          emit(currentState);
        }
      }
    });
  }
}
