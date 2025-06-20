part of 'connectivity_bloc.dart';

@immutable
sealed class ConnectivityState {}

final class ConnectivityInitial extends ConnectivityState {}
final class ConnectivitySuccess extends ConnectivityState {
  final List<ConnectivityResult> results;

  ConnectivitySuccess({required this.results});
}

class ConnectivityFailure extends ConnectivityState {}

class ConnectivityRestored extends ConnectivityState {
  final List<ConnectivityResult> results;

  ConnectivityRestored({required this.results});
}