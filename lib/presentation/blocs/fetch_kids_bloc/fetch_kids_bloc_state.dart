part of 'fetch_kids_bloc_bloc.dart';

@immutable
sealed class FetchKidsBlocState {}

final class FetchKidsBlocInitial extends FetchKidsBlocState {}

final class FetchKidsLoadingState extends FetchKidsBlocState {}

final class FetchKidsSuccessState extends FetchKidsBlocState {
  final List<StudentListModel> students;

  FetchKidsSuccessState({required this.students});
}

final class FetchKidsErrorState extends FetchKidsBlocState {
  final String message;

  FetchKidsErrorState({required this.message});
}
