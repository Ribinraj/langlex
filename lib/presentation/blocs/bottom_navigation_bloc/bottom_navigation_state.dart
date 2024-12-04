part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {
  final int currentPageIndex;

  const BottomNavigationState({required this.currentPageIndex});
}

final class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial() : super(currentPageIndex: 0);
}

final class NavigationState extends BottomNavigationState {
  const NavigationState({required super.currentPageIndex});
}
