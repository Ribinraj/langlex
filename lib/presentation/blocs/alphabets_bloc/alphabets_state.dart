part of 'alphabets_bloc.dart';

@immutable
sealed class AlphabetsState {}

final class AlphabetsInitial extends AlphabetsState {}
final class AlphabetsBlocLoadingState extends AlphabetsState{}
final class AlphabetsBlocSuccessState extends AlphabetsState{
  final List<AlphabetModel>alphabets;

  AlphabetsBlocSuccessState({required this.alphabets});
}
final class AlphabetBlocErrorState extends AlphabetsState{
  final String message;

  AlphabetBlocErrorState({required this.message});
}