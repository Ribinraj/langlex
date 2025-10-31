part of 'fetch_secondarycategory_bloc.dart';

@immutable
sealed class FetchSecondarycategoryEvent {}
final class FetchsecondaryCategoryButtonClickEvent extends FetchSecondarycategoryEvent {
  final String category;
  final int languageId;
  final int primaryCategoryId;

  FetchsecondaryCategoryButtonClickEvent({
    required this.category,
    required this.languageId,
    required this.primaryCategoryId,
  });
}