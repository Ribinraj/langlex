import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial()) {
    on<BottomNavigationEvent>((event, emit) {});
    on<NavigateToPageEvent>(navigatepageevent);
  }

  FutureOr<void> navigatepageevent(
      NavigateToPageEvent event, Emitter<BottomNavigationState> emit) {
    emit(NavigationState(currentPageIndex: event.pageIndex));
  }
}
