import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/profile_model.dart';
import 'package:langlex/domain/repository/login_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_profile_event.dart';
part 'fetch_profile_state.dart';

class FetchProfileBloc extends Bloc<FetchProfileEvent, FetchProfileState> {
  final Loginrepo repository;
  FetchProfileBloc({required this.repository}) : super(FetchProfileInitial()) {
    on<FetchProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchProfileButtonClickEvent>(fetchprofile);
  }

  FutureOr<void> fetchprofile(FetchProfileButtonClickEvent event, Emitter<FetchProfileState> emit) async{
    emit(FetchProfileLoadingState());
    try {
      final response=await repository.fetchprofile();
      if (!response.error && response.status==200) {
        emit(FetchProfileSuccessState(profile: response.data!));
      }
      else{
        emit(FetchProfileErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchProfileErrorState(message: e.toString()));
    }
  }
}
