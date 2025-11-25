import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/alphabet_model.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'alphabets_event.dart';
part 'alphabets_state.dart';

class AlphabetsBloc extends Bloc<AlphabetsEvent, AlphabetsState> {
  final AppRepo repository;
  AlphabetsBloc({required this.repository}) : super(AlphabetsInitial()) {
    on<AlphabetsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AlphabetsBlocFetchingInitialEvent>(fetchalpabets);
  }

  FutureOr<void> fetchalpabets(AlphabetsBlocFetchingInitialEvent event, Emitter<AlphabetsState> emit)async {
    emit(AlphabetsBlocLoadingState());
    try {
      final response=await repository.fetchalphabets(languageId: event.languagId);
      if (!response.error && response.status==200) {
        emit(AlphabetsBlocSuccessState(alphabets: response.data!));
      }else{
        emit(AlphabetBlocErrorState(message: response.message));
      }
    } catch (e) {
      emit(AlphabetBlocErrorState(message: e.toString()));
    }
  }
}
