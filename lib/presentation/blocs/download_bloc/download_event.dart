part of 'download_bloc.dart';

@immutable
abstract class DownloadEvent {
  const DownloadEvent();
}

class DownloadRequested extends DownloadEvent {
  final int secondaryCategoryId;
  final int primaryCategoryId;
  final int languageId;
  final bool force; // true for refresh

  const DownloadRequested({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
    required this.languageId,
    this.force = false,
  });
}

class RefreshRequested extends DownloadEvent {
  final int secondaryCategoryId;
  final int primaryCategoryId;
  final int languageId;

  const RefreshRequested({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
    required this.languageId,
  });
}

class CheckLocalAvailability extends DownloadEvent {
  final int secondaryCategoryId;
  const CheckLocalAvailability(this.secondaryCategoryId);
}
