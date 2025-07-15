import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/language_model.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_languages_event.dart';
part 'fetch_languages_state.dart';

class FetchLanguagesBloc
    extends Bloc<FetchLanguagesEvent, FetchLanguagesState> {
  final AppRepo repository;
  FetchLanguagesBloc({required this.repository})
      : super(FetchLanguagesInitial()) {
    on<FetchLanguagesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchLanguagesInitialEvent>(fetchlanguages);
  }

  FutureOr<void> fetchlanguages(FetchLanguagesInitialEvent event,
      Emitter<FetchLanguagesState> emit) async {
    emit(FetchLanguagesLoadingState());
    try {
      final response = await repository.fetchlanguages();
      if (!response.error && response.status == 200) {
        emit(FetchLanguagesSuccessState(languages: response.data!));
      } else {
        emit(FetchLanguagesErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchLanguagesErrorState(message: e.toString()));
    }
  }
}
