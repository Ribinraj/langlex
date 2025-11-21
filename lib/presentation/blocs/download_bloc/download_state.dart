part of 'download_bloc.dart';

enum DownloadItemStatus {
  idle,
  queued,
  downloading,
  completed,
  failed,
}

@immutable
class DownloadItemState {
  final int secondaryCategoryId;
  final DownloadItemStatus status;
  final double progress; // 0..1
  final String? error;
  final bool hasLocal;

  const DownloadItemState({
    required this.secondaryCategoryId,
    this.status = DownloadItemStatus.idle,
    this.progress = 0.0,
    this.error,
    this.hasLocal = false,
  });

  DownloadItemState copyWith({
    DownloadItemStatus? status,
    double? progress,
    String? error,       // pass null to clear
    bool? hasLocal,
  }) {
    return DownloadItemState(
      secondaryCategoryId: secondaryCategoryId,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      error: error,
      hasLocal: hasLocal ?? this.hasLocal,
    );
  }
}

@immutable
class DownloadState {
  final Map<int, DownloadItemState> items;
  const DownloadState({this.items = const {}});

  DownloadItemState itemOf(int id) {
    return items[id] ?? DownloadItemState(secondaryCategoryId: id);
  }

  DownloadState upsert(DownloadItemState item) {
    final next = Map<int, DownloadItemState>.from(items);
    next[item.secondaryCategoryId] = item;
    return DownloadState(items: next);
  }
}
