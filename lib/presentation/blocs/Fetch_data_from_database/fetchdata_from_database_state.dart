part of 'fetchdata_from_database_bloc.dart';

@immutable
sealed class FetchdataFromDatabaseState {}

final class FetchdataFromDatabaseInitial extends FetchdataFromDatabaseState {}

final class FetchDataFromDatabaseLoadingState
    extends FetchdataFromDatabaseState {}

final class FetchDataFromDatabaseSuccessState
    extends FetchdataFromDatabaseState {
  final List<DataItem> dataItems;

  FetchDataFromDatabaseSuccessState({required this.dataItems});
}
final class FetchDataFromDatabaseErrrorState extends FetchdataFromDatabaseState{}
