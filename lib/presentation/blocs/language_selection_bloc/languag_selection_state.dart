part of 'languag_selection_bloc.dart';

@immutable
class LanguageSelectionState {
  final List<Language> selectedLanguages;
  final bool isMaxSelected;
  final bool canSubmit;

  const LanguageSelectionState({
    this.selectedLanguages = const [],
    this.isMaxSelected = false,
    this.canSubmit = false,
  });

  LanguageSelectionState copyWith({
    List<Language>? selectedLanguages,
    bool? isMaxSelected,
    bool? canSubmit,
  }) {
    return LanguageSelectionState(
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      isMaxSelected: isMaxSelected ?? this.isMaxSelected,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

//////////////////////////
class Language {
  final String code;
  final String name;
  final String nativeName;
  final String flag;

  const Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
  });


}
