part of 'alphabets_details_bloc.dart';

@immutable
sealed class AlphabetsDetailsState {}

final class AlphabetsDetailsInitial extends AlphabetsDetailsState {}
final class AlphaetsDetailsLoadingState extends AlphabetsDetailsState{}
final class AlphabetsDetailsSuccessState extends AlphabetsDetailsState{
  final List<AlphabetModel> letters;

  AlphabetsDetailsSuccessState({required this.letters});
}
final class AlphabetsDetailsErrorState extends AlphabetsDetailsState{
  final String message;

  AlphabetsDetailsErrorState({required this.message});
}