part of 'content_download_bloc.dart';

@immutable
sealed class ContentDownloadEvent {}

class CheckDownloadStatusEvent extends ContentDownloadEvent {}

class DownloadButtonClickEvent extends ContentDownloadEvent {}

class RedownloadButtonClickEvent extends ContentDownloadEvent {}