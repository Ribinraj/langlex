part of 'connectivity_bloc.dart';

@immutable
sealed class ConnectivityEvent {}
final class CheckConnectivity extends ConnectivityEvent{}