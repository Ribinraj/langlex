import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/edit_profilemodel.dart';
import 'package:langlex/domain/repository/login_repo.dart';
import 'package:meta/meta.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final Loginrepo repository;
  UpdateProfileBloc({required this.repository}) : super(UpdateProfileInitial()) {
on<UpdateProfileButtonClickEvent>(updateprofile);
  }

  FutureOr<void> updateprofile(UpdateProfileButtonClickEvent event, Emitter<UpdateProfileState> emit) async{
    emit(UpdateProfileLoadingState());
    try {
      final response=await repository.updateprofiel(student: event.profile);
      if (!response.error && response.status==200) {
        emit(UpdateProfileSuccessState(message: response.message));
      }
      else{
        emit(UpdateProfileErrorState(message: response.message));
      }
    } catch (e) {
        emit(UpdateProfileErrorState(message:e.toString()));
    }
  }
}
