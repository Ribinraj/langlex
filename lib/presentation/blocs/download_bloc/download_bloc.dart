import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:langlex/domain/repository/app_repo.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final AppRepo repository;

  DownloadBloc({required this.repository}) : super(const DownloadState()) {
    on<CheckLocalAvailability>(_onCheckLocal);
    on<RefreshRequested>(_onRefresh);
    on<DownloadRequested>(_onDownload);
  }

  Future<void> _onCheckLocal(
    CheckLocalAvailability event,
    Emitter<DownloadState> emit,
  ) async {
    try {
      final hasLocal = await repository.isKnowledgeDownloaded(
        secondaryCategoryId: event.secondaryCategoryId,
      );
      final cur = state.itemOf(event.secondaryCategoryId);
      emit(state.upsert(cur.copyWith(hasLocal: hasLocal)));
    } catch (_) {
      // ignore errors; keep previous state
    }
  }

  Future<void> _onRefresh(
    RefreshRequested event,
    Emitter<DownloadState> emit,
  ) async {
    add(DownloadRequested(
      secondaryCategoryId: event.secondaryCategoryId,
      primaryCategoryId: event.primaryCategoryId,
      languageId: event.languageId,
      force: true,
    ));
  }

  Future<void> _onDownload(
    DownloadRequested event,
    Emitter<DownloadState> emit,
  ) async {
    final id = event.secondaryCategoryId;
    final cur = state.itemOf(id);

    // ignore repeated taps while downloading
    if (cur.status == DownloadItemStatus.downloading) return;

    emit(state.upsert(cur.copyWith(
      status: DownloadItemStatus.queued,
      progress: 0.0,
      error: null,
    )));

    try {
      await repository.downloadAndExtractKnowledgeZip(
        secondaryCategoryId: event.secondaryCategoryId,
        primaryCategoryId: event.primaryCategoryId,
        languageId: event.languageId,
        forceDownload: event.force,
        onProgress: (p) {
          log('[$id] ${(p * 100).toStringAsFixed(0)}%');
          final now = state.itemOf(id);
          emit(state.upsert(now.copyWith(
            status: DownloadItemStatus.downloading,
            progress: p,
            error: null,
          )));
        },
      );

      emit(state.upsert(state.itemOf(id).copyWith(
        status: DownloadItemStatus.completed,
        progress: 1.0,
        hasLocal: true,
        error: null,
      )));
    } catch (e) {
      emit(state.upsert(state.itemOf(id).copyWith(
        status: DownloadItemStatus.failed,
        error: e.toString(),
      )));
    }
  }
}

