import 'package:fam_assignment/faetures/contextual_cards/domain/usecases/home_section_usecase.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/home_section_model.dart';
import 'package:fam_assignment/core/services/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_section_event.dart';
part 'home_section_state.dart';

class HomeSectionBloc extends Bloc<HomeSectionEvent, HomeSectionState> {
  final HomeSectionUsecase homeSectionUsecase;
  final StorageService storageService;

  HomeSectionBloc(this.homeSectionUsecase, this.storageService)
    : super(HomeSectionInitial()) {
    on<FetchHomeSectionEvent>((event, emit) async {
      emit(HomeSectionLoading());
      try {
        await storageService.clearRemindLaterCards();

        final homeSection = await homeSectionUsecase.fetchHomeSection();
        if (homeSection.isEmpty) {
          emit(HomeSectionEmpty());
        } else {
          final hiddenCardIds = storageService.getDismissedCards();
          // final hiddenCardIds = [
          //   ...storageService.getDismissedCards(),
          //   ...storageService.getRemindLaterCards(),
          // ];
          emit(HomeSectionLoaded(homeSection, hiddenCardIds));
        }
      } catch (e) {
        emit(HomeSectionError(e.toString()));
      }
    });

    on<DismissCardEvent>((event, emit) async {
      if (state is HomeSectionLoaded) {
        final currentState = state as HomeSectionLoaded;
        await storageService.dismissCard(event.cardId);

        final hiddenCardIds = [
          ...storageService.getDismissedCards(),
          ...storageService.getRemindLaterCards(),
        ];

        emit(HomeSectionLoaded(currentState.homeSections, hiddenCardIds));
      }
    });

    on<RemindLaterCardEvent>((event, emit) async {
      if (state is HomeSectionLoaded) {
        final currentState = state as HomeSectionLoaded;
        await storageService.remindLater(event.cardId);

        final hiddenCardIds = [
          ...storageService.getDismissedCards(),
          ...storageService.getRemindLaterCards(),
        ];

        emit(HomeSectionLoaded(currentState.homeSections, hiddenCardIds));
      }
    });
  }
}
