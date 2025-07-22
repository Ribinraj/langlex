import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/student_list_model.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_kids_bloc_event.dart';
part 'fetch_kids_bloc_state.dart';

class FetchKidsBlocBloc extends Bloc<FetchKidsBlocEvent, FetchKidsBlocState> {
  final AppRepo repository;
  FetchKidsBlocBloc({required this.repository})
      : super(FetchKidsBlocInitial()) {
    on<FetchKidsBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchKidsInitialEvent>(fetchkids);
  }

  FutureOr<void> fetchkids(
      FetchKidsInitialEvent event, Emitter<FetchKidsBlocState> emit) async {
    emit(FetchKidsLoadingState());
    try {
      final response = await repository.fetchkidsList();
      if (!response.error && response.status == 200) {
        emit(FetchKidsSuccessState(students: response.data!));
      } else {
        emit(FetchKidsErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchKidsErrorState(message: e.toString()));
    }
  }
}
