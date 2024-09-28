import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/Data_model.dart';
import 'package:langlex/domain/repository/Datadownload_repository.dart';
import 'package:meta/meta.dart';

part 'fetchdata_from_database_event.dart';
part 'fetchdata_from_database_state.dart';

class FetchdataFromDatabaseBloc
    extends Bloc<FetchdataFromDatabaseEvent, FetchdataFromDatabaseState> {
  FetchdataFromDatabaseBloc() : super(FetchdataFromDatabaseInitial()) {
    on<FetchdataFromDatabaseEvent>((event, emit) {});
    on<FetchDataFromDatabaseInitialEvent>(fetchdatafromdatabase);
  }

  FutureOr<void> fetchdatafromdatabase(FetchDataFromDatabaseInitialEvent event,
      Emitter<FetchdataFromDatabaseState> emit) async {
    emit(FetchDataFromDatabaseLoadingState());
    try {
      final List<DataItem> dataItems =
          await DownloadRepository.getDataFromDatabase();
      emit(FetchDataFromDatabaseSuccessState(dataItems: dataItems));
    } catch (e) {
      emit(FetchDataFromDatabaseErrrorState());
    }
  }
}
