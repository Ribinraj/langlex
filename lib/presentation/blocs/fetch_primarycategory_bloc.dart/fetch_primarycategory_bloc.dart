import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/primary_model.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_primarycategory_event.dart';
part 'fetch_primarycategory_state.dart';

class FetchPrimarycategoryBloc
    extends Bloc<FetchPrimarycategoryEvent, FetchPrimarycategoryState> {
  final AppRepo repository;
  FetchPrimarycategoryBloc({required this.repository})
      : super(FetchPrimarycategoryInitial()) {
    on<FetchPrimarycategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchPrimaryCategoryInitialEvent>(fetchprimarycategories);
  }

  FutureOr<void> fetchprimarycategories(FetchPrimaryCategoryInitialEvent event,
      Emitter<FetchPrimarycategoryState> emit) async {
    emit(FetchPrimarycategoryLoadingState());
    try {
      final response = await repository.fetchprimaryCategory(
          category: event.category, languageId: event.languageId);
      if (!response.error && response.status == 200) {
        emit(FetchPrimarycategorySuccessState(
            primaryCategories: response.data!));
      } else {
        emit(FetchPrimaryCategoryErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchPrimaryCategoryErrorState(message: e.toString()));
    }
  }
}
