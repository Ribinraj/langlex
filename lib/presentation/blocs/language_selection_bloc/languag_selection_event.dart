part of 'languag_selection_bloc.dart';

@immutable
abstract class LanguageSelectionEvent {
  const LanguageSelectionEvent();
}

class ToggleLanguageSelection extends LanguageSelectionEvent {
  final Language language;

  const ToggleLanguageSelection(this.language);
}

class ResetSelection extends LanguageSelectionEvent {}
