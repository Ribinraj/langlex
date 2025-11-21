part of 'fetch_profile_bloc.dart';

@immutable
sealed class FetchProfileState {}

final class FetchProfileInitial extends FetchProfileState {}
final class FetchProfileLoadingState extends FetchProfileState{}
final class FetchProfileSuccessState extends  FetchProfileState{
  final ProfileModel profile;

  FetchProfileSuccessState({required this.profile});
}
final class FetchProfileErrorState extends FetchProfileState{
  final String message;

  FetchProfileErrorState({required this.message});
}