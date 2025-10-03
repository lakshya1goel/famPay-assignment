import 'package:fam_assignment/faetures/contextual_cards/domain/usecases/home_section_usecase.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/models/home_section_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_section_event.dart';
part 'home_section_state.dart';

class HomeSectionBloc extends Bloc<HomeSectionEvent, HomeSectionState> {
  final HomeSectionUsecase homeSectionUsecase;

  HomeSectionBloc(this.homeSectionUsecase) : super(HomeSectionInitial()) {
    on<FetchHomeSectionEvent>((event, emit) async {
      emit(HomeSectionLoading());
      try {
        final homeSection = await homeSectionUsecase.fetchHomeSection();
        if (homeSection.isEmpty) {
          emit(HomeSectionEmpty());
        } else {
          emit(HomeSectionLoaded(homeSection));
        }
      } catch (e) {
        emit(HomeSectionError(e.toString()));
      }
    });

    on<DismissCardEvent>((event, emit) {
    });

    on<RemindLaterCardEvent>((event, emit) {
    });
  }
}
