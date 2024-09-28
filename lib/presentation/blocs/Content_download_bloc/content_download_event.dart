part of 'content_download_bloc.dart';

@immutable
sealed class ContentDownloadEvent {}
class DownlaodButtonClickEvent extends ContentDownloadEvent{}