part of 'fetch_primarycategory_bloc.dart';

@immutable
sealed class FetchPrimarycategoryEvent {}

final class FetchPrimaryCategoryInitialEvent extends FetchPrimarycategoryEvent {
  final String category;
  final int languageId;

  FetchPrimaryCategoryInitialEvent({required this.category, required this.languageId});
}
