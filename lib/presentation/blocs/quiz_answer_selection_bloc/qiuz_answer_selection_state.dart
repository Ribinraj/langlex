part of 'qiuz_answer_selection_bloc.dart';

@immutable
sealed class QiuzAnswerSelectionState {}

final class QiuzAnswerSelectionInitial extends QiuzAnswerSelectionState {}

final class AnswerSelectedState extends QiuzAnswerSelectionState {
  final int selectedIndex;

  AnswerSelectedState({required this.selectedIndex});
}
