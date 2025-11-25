part of 'alphabets_details_bloc.dart';

@immutable
sealed class AlphabetsDetailsEvent {}
final class AlphabetsDetailsFetchingInitialEvent extends AlphabetsDetailsEvent{
  final String alphabet;

  AlphabetsDetailsFetchingInitialEvent({required this.alphabet});
}