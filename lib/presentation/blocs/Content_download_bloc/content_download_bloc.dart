import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:langlex/domain/repository/Datadownload_repository.dart';
import 'package:meta/meta.dart';

part 'content_download_event.dart';
part 'content_download_state.dart';

class ContentDownloadBloc extends Bloc<ContentDownloadEvent, ContentDownloadState> {
  final DownloadRepository repository;
  
  ContentDownloadBloc({required this.repository}) : super(ContentDownloadInitial()) {
    on<CheckDownloadStatusEvent>(_onCheckDownloadStatus);
    on<DownloadButtonClickEvent>(_onDownloadClick);
    on<RedownloadButtonClickEvent>(_onRedownloadClick);
  }

  // Check if data is already downloaded when bloc initializes
  FutureOr<void> _onCheckDownloadStatus(
    CheckDownloadStatusEvent event, 
    Emitter<ContentDownloadState> emit
  ) async {
    try {
      final dataItems = await DownloadRepository.getDataFromDatabase();
      if (dataItems.isNotEmpty) {
        emit(ContentDownloadSuccessState());
      } else {
        emit(ContentDownloadInitial());
      }
    } catch (e) {
      emit(ContentDownloadInitial());
    }
  }

  // Handle fresh download
  FutureOr<void> _onDownloadClick(
    DownloadButtonClickEvent event, 
    Emitter<ContentDownloadState> emit
  ) async {
    emit(ContentDownloadLoading());
    try {
      await repository.download();
      emit(ContentDownloadSuccessState());
    } catch (e) {
      emit(ContentDownloadErrorState(error: e.toString()));
    }
  }

  // Handle redownload (clears existing data first)
  FutureOr<void> _onRedownloadClick(
    RedownloadButtonClickEvent event, 
    Emitter<ContentDownloadState> emit
  ) async {
    emit(ContentDownloadLoading());
    try {
      // Clear existing data before redownloading
      await repository.clearExistingData();
      await repository.download();
      emit(ContentDownloadSuccessState());
    } catch (e) {
      emit(ContentDownloadErrorState(error: e.toString()));
    }
  }
}