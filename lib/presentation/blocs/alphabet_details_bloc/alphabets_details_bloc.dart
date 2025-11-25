import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:langlex/data/models/alphabet_model.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'alphabets_details_event.dart';
part 'alphabets_details_state.dart';

class AlphabetsDetailsBloc extends Bloc<AlphabetsDetailsEvent, AlphabetsDetailsState> {
  final AppRepo repository;
  AlphabetsDetailsBloc({required this.repository}) : super(AlphabetsDetailsInitial()) {
    on<AlphabetsDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AlphabetsDetailsFetchingInitialEvent>(alphabetdetailsfetching);
  }

  FutureOr<void> alphabetdetailsfetching(AlphabetsDetailsFetchingInitialEvent event, Emitter<AlphabetsDetailsState> emit) async{
    emit(AlphaetsDetailsLoadingState());
    try {
      final response=await repository.fetchalphabetsdetails(letter: event.alphabet);
      if (!response.error && response.status==200) {
        emit(AlphabetsDetailsSuccessState(letters: response.data!));
      }else{
        emit(AlphabetsDetailsErrorState(message: response.message));
      }
    } catch (e) {
         emit(AlphabetsDetailsErrorState(message: e.toString()));
    }
  }
}
