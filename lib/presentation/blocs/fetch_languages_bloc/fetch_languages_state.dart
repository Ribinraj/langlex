part of 'fetch_languages_bloc.dart';

@immutable
sealed class FetchLanguagesState {}

final class FetchLanguagesInitial extends FetchLanguagesState {}

final class FetchLanguagesLoadingState extends FetchLanguagesState {}

final class FetchLanguagesSuccessState extends FetchLanguagesState {
  final List<LanguageModel> languages;

  FetchLanguagesSuccessState({required this.languages});
}

final class FetchLanguagesErrorState extends FetchLanguagesState {
  final String message;

  FetchLanguagesErrorState({required this.message});
}
