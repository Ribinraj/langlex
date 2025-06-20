part of 'content_download_bloc.dart';

@immutable
sealed class ContentDownloadState {}

final class ContentDownloadInitial extends ContentDownloadState {}

final class ContentDownloadLoading extends ContentDownloadState {}

final class ContentDownloadSuccessState extends ContentDownloadState {}

final class ContentDownloadErrorState extends ContentDownloadState {
  final String error;
  
  ContentDownloadErrorState({required this.error});
}