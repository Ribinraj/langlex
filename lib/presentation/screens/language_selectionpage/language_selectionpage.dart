import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/blocs/language_selection_bloc/languag_selection_bloc.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  _LanguageSelectionPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextStyles.subheadline(
            text: 'Select Languages', color: Appcolors.kwhiteColor),
        backgroundColor: Appcolors.kprimarycolor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<LanguageSelectionBloc>().add(ResetSelection());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Appcolors.korangelightColor.withOpacity(.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Appcolors.korangeColor),
            ),
            child: BlocBuilder<LanguageSelectionBloc, LanguageSelectionState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Text(
                      'Select exactly 3 languages',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${state.selectedLanguages.length}/3 selected',
                      style: TextStyle(
                        fontSize: 14,
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LanguageSelectionBloc, LanguageSelectionState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: LanguageData.languages.length,
                  itemBuilder: (context, index) {
                    final language = LanguageData.languages[index];
                    final isSelected =
                        state.selectedLanguages.contains(language);
                    final canSelect = !state.isMaxSelected || isSelected;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      elevation: isSelected ? 4 : 1,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              isSelected ? Colors.blue : Colors.grey.shade200,
                          child: Text(
                            language.flag,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        title: Text(
                          language.name,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: canSelect ? Colors.black : Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          language.nativeName,
                          style: TextStyle(
                            color: canSelect
                                ? Colors.grey.shade600
                                : Colors.grey.shade400,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green.shade600,
                              )
                            : canSelect
                                ? Icon(
                                    Icons.circle_outlined,
                                    color: Colors.grey.shade400,
                                  )
                                : Icon(
                                    Icons.block,
                                    color: Colors.grey.shade300,
                                  ),
                        onTap: canSelect
                            ? () {
                                context.read<LanguageSelectionBloc>().add(
                                      ToggleLanguageSelection(language),
                                    );
                              }
                            : null,
                        tileColor: isSelected
                            ? Colors.blue.shade50
                            : canSelect
                                ? Colors.white
                                : Colors.grey.shade50,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<LanguageSelectionBloc, LanguageSelectionState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (state.selectedLanguages.isNotEmpty) ...[
                      Text(
                        'Selected Languages:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: state.selectedLanguages.map((language) {
                          return Chip(
                            avatar: Text(language.flag),
                            label: Text(language.name),
                            backgroundColor:
                                Appcolors.kgreenlightColor.withOpacity(.3),
                            onDeleted: () {
                              context.read<LanguageSelectionBloc>().add(
                                    ToggleLanguageSelection(language),
                                  );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                    ElevatedButton(
                      onPressed: state.canSubmit
                          ? () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => NextPage(
                              //       selectedLanguages: state.selectedLanguages,
                              //     ),
                              //   ),
                              // );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.canSubmit
                            ? Appcolors.korangeColor
                            : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////
class LanguageData {
  static const List<Language> languages = [
    Language(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
    ),
    Language(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      flag: '🇪🇸',
    ),
    Language(
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      flag: '🇫🇷',
    ),
    Language(
      code: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      flag: '🇩🇪',
    ),
    Language(
      code: 'it',
      name: 'Italian',
      nativeName: 'Italiano',
      flag: '🇮🇹',
    ),
    Language(
      code: 'pt',
      name: 'Portuguese',
      nativeName: 'Português',
      flag: '🇵🇹',
    ),
    Language(
      code: 'ru',
      name: 'Russian',
      nativeName: 'Русский',
      flag: '🇷🇺',
    ),
    Language(
      code: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      flag: '🇯🇵',
    ),
    Language(
      code: 'ko',
      name: 'Korean',
      nativeName: '한국어',
      flag: '🇰🇷',
    ),
    Language(
      code: 'zh',
      name: 'Chinese',
      nativeName: '中文',
      flag: '🇨🇳',
    ),
    Language(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      flag: '🇸🇦',
    ),
    Language(
      code: 'hi',
      name: 'Hindi',
      nativeName: 'हिन्दी',
      flag: '🇮🇳',
    ),
  ];
}
