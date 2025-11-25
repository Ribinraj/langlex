part of 'alphabets_bloc.dart';

@immutable
sealed class AlphabetsEvent {}
final class AlphabetsBlocFetchingInitialEvent extends AlphabetsEvent{
  final int languagId;

  AlphabetsBlocFetchingInitialEvent({required this.languagId});
}