part of 'fetch_secondarycategory_bloc.dart';

@immutable
sealed class FetchSecondarycategoryState {}

final class FetchSecondarycategoryInitial extends FetchSecondarycategoryState {}
final class FetchSecondarycategoryLoading extends FetchSecondarycategoryState{}
final class FetchSecondarycategorySuccessState extends FetchSecondarycategoryState {
  final List<SecondaryModel> secondarycategories;

  FetchSecondarycategorySuccessState({required this.secondarycategories});
  
}
final class FetchSecondarycategoryErrorState extends FetchSecondarycategoryState {
  final String errorMessage;

  FetchSecondarycategoryErrorState({required this.errorMessage});

 
}