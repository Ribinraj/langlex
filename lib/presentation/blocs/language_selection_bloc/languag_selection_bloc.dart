import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'languag_selection_event.dart';
part 'languag_selection_state.dart';

class LanguageSelectionBloc
    extends Bloc<LanguageSelectionEvent, LanguageSelectionState> {
  LanguageSelectionBloc() : super(const LanguageSelectionState()) {
    on<ToggleLanguageSelection>(_onToggleLanguageSelection);
    on<ResetSelection>(_onResetSelection);
  }

  void _onToggleLanguageSelection(
    ToggleLanguageSelection event,
    Emitter<LanguageSelectionState> emit,
  ) {
    final selectedLanguages = List<Language>.from(state.selectedLanguages);

    if (selectedLanguages.contains(event.language)) {
      // Remove language if already selected
      selectedLanguages.remove(event.language);
    } else {
      // Add language if not at max limit
      if (selectedLanguages.length < 3) {
        selectedLanguages.add(event.language);
      } else {
        // Already at max, don't add
        return;
      }
    }

    emit(state.copyWith(
      selectedLanguages: selectedLanguages,
      isMaxSelected: selectedLanguages.length == 3,
      canSubmit: selectedLanguages.length == 3,
    ));
  }
    void _onResetSelection(
    ResetSelection event,
    Emitter<LanguageSelectionState> emit,
  ) {
    emit(const LanguageSelectionState());
  }
}
