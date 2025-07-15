part of 'fetch_languages_bloc.dart';

@immutable
sealed class FetchLanguagesEvent {}
final class FetchLanguagesInitialEvent extends FetchLanguagesEvent{}