part of 'qiuz_answer_selection_bloc.dart';

@immutable
sealed class QiuzAnswerSelectionEvent {}

final class SelectAnswerEvent extends QiuzAnswerSelectionEvent {
  final int selectedIndex;

  SelectAnswerEvent({required this.selectedIndex});
}
