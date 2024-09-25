import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qiuz_answer_selection_event.dart';
part 'qiuz_answer_selection_state.dart';

class QiuzAnswerSelectionBloc
    extends Bloc<QiuzAnswerSelectionEvent, QiuzAnswerSelectionState> {
  QiuzAnswerSelectionBloc() : super(QiuzAnswerSelectionInitial()) {
    on<QiuzAnswerSelectionEvent>((event, emit) {});
    on<SelectAnswerEvent>(selectanswerevent);
  }

  FutureOr<void> selectanswerevent(
      SelectAnswerEvent event, Emitter<QiuzAnswerSelectionState> emit) {
    emit(AnswerSelectedState(selectedIndex: event.selectedIndex));
  }
}
