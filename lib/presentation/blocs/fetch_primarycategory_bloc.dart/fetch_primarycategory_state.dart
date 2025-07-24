part of 'fetch_primarycategory_bloc.dart';

@immutable
sealed class FetchPrimarycategoryState {}

final class FetchPrimarycategoryInitial extends FetchPrimarycategoryState {}

final class FetchPrimarycategoryLoadingState
    extends FetchPrimarycategoryState {}

final class FetchPrimarycategorySuccessState extends FetchPrimarycategoryState {
  final List<PrimaryCategoryModel> primaryCategories;

  FetchPrimarycategorySuccessState({required this.primaryCategories});
}

final class FetchPrimaryCategoryErrorState extends FetchPrimarycategoryState {
  final String message;

  FetchPrimaryCategoryErrorState({required this.message});
}
