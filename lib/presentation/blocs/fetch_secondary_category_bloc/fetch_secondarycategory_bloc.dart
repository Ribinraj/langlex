import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/secondary_model.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_secondarycategory_event.dart';
part 'fetch_secondarycategory_state.dart';

class FetchSecondarycategoryBloc extends Bloc<FetchSecondarycategoryEvent, FetchSecondarycategoryState> {
  final AppRepo repository;
  FetchSecondarycategoryBloc({required this.repository}) : super(FetchSecondarycategoryInitial()) {
    on<FetchSecondarycategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchsecondaryCategoryButtonClickEvent>(fetchsecondaryCategory);
  }

  FutureOr<void> fetchsecondaryCategory(FetchsecondaryCategoryButtonClickEvent event, Emitter<FetchSecondarycategoryState> emit) async {
    emit(FetchSecondarycategoryLoading());
    try {
      final response = await repository.fetchsecondaryCategory(
          category: event.category,
          languageId: event.languageId,
          primaryCategoryId: event.primaryCategoryId);
      if (!response.error) {
        emit(FetchSecondarycategorySuccessState(
            secondarycategories: response.data!));
      } else {
        emit(FetchSecondarycategoryErrorState(
            errorMessage: response.message ));
      }
    } catch (e) {
      emit(FetchSecondarycategoryErrorState(
          errorMessage: e.toString()));
    }
  }
}
