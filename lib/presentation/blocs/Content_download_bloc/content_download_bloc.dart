import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/domain/repository/Datadownload_repository.dart';
import 'package:meta/meta.dart';

part 'content_download_event.dart';
part 'content_download_state.dart';

class ContentDownloadBloc
    extends Bloc<ContentDownloadEvent, ContentDownloadState> {
  final DownloadRepository repository;
  ContentDownloadBloc({required this.repository})
      : super(ContentDownloadInitial()) {
    on<ContentDownloadEvent>((event, emit) {});
    on<DownlaodButtonClickEvent>(downloadevent);
  }

  FutureOr<void> downloadevent(DownlaodButtonClickEvent event,
      Emitter<ContentDownloadState> emit) async {
    emit(ContentDownloadLoading());
    try {
      await repository.download();
      emit(ContentDownloadSuccessState());
    } catch (e) {
      emit(ContentDownloadErrorState());
    }
  }
}
