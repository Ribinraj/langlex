// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:langlex/core/colors.dart';
// // import 'package:langlex/core/constants.dart';
// // import 'package:langlex/presentation/blocs/language_selection_bloc/languag_selection_bloc.dart';

// // class LanguageSelectionPage extends StatefulWidget {
// //   const LanguageSelectionPage({super.key});

// //   @override
// //   State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
// // }

// // class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
// //   _LanguageSelectionPageState();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: TextStyles.subheadline(
// //             text: 'Select Languages', color: Appcolors.kwhiteColor),
// //         backgroundColor: Appcolors.kprimarycolor,
// //         foregroundColor: Colors.white,
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.refresh),
// //             onPressed: () {
// //               context.read<LanguageSelectionBloc>().add(ResetSelection());
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           Container(
// //             width: double.infinity,
// //             padding: const EdgeInsets.all(16),
// //             margin: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: Appcolors.korangelightColor.withOpacity(.5),
// //               borderRadius: BorderRadius.circular(12),
// //               border: Border.all(color: Appcolors.korangeColor),
// //             ),
// //             child: BlocBuilder<LanguageSelectionBloc, LanguageSelectionState>(
// //               builder: (context, state) {
// //                 return Column(
// //                   children: [
// //                     Text(
// //                       'Select exactly 3 languages',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                         color: Appcolors.kprimarycolor,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       '${state.selectedLanguages.length}/3 selected',
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         color: Appcolors.kprimarycolor,
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               },
// //             ),
// //           ),
// //           Expanded(
// //             child: BlocBuilder<LanguageSelectionBloc, LanguageSelectionState>(
// //               builder: (context, state) {
// //                 return ListView.builder(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16),
// //                   itemCount: LanguageData.languages.length,
// //                   itemBuilder: (context, index) {
// //                     final language = LanguageData.languages[index];
// //                     final isSelected =
// //                         state.selectedLanguages.contains(language);
// //                     final canSelect = !state.isMaxSelected || isSelected;

// //                     return Card(
// //                       margin: const EdgeInsets.only(bottom: 8),
// //                       elevation: isSelected ? 4 : 1,
// //                       child: ListTile(
// //                         leading: CircleAvatar(
// //                           backgroundColor:
// //                               isSelected ? Colors.blue : Colors.grey.shade200,
// //                           child: Text(
// //                             language.flag,
// //                             style: const TextStyle(fontSize: 20),
// //                           ),
// //                         ),
// //                         title: Text(
// //                           language.name,
// //                           style: TextStyle(
// //                             fontWeight: isSelected
// //                                 ? FontWeight.bold
// //                                 : FontWeight.normal,
// //                             color: canSelect ? Colors.black : Colors.grey,
// //                           ),
// //                         ),
// //                         subtitle: Text(
// //                           language.nativeName,
// //                           style: TextStyle(
// //                             color: canSelect
// //                                 ? Colors.grey.shade600
// //                                 : Colors.grey.shade400,
// //                           ),
// //                         ),
// //                         trailing: isSelected
// //                             ? Icon(
// //                                 Icons.check_circle,
// //                                 color: Colors.green.shade600,
// //                               )
// //                             : canSelect
// //                                 ? Icon(
// //                                     Icons.circle_outlined,
// //                                     color: Colors.grey.shade400,
// //                                   )
// //                                 : Icon(
// //                                     Icons.block,
// //                                     color: Colors.grey.shade300,
// //                                   ),
// //                         onTap: canSelect
// //                             ? () {
// //                                 context.read<LanguageSelectionBloc>().add(
// //                                       ToggleLanguageSelection(language),
// //                                     );
// //                               }
// //                             : null,
// //                         tileColor: isSelected
// //                             ? Colors.blue.shade50
// //                             : canSelect
// //                                 ? Colors.white
// //                                 : Colors.grey.shade50,
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           Container(
// //             width: double.infinity,
// //             padding: const EdgeInsets.all(16),
// //             child: BlocBuilder<LanguageSelectionBloc, LanguageSelectionState>(
// //               builder: (context, state) {
// //                 return Column(
// //                   children: [
// //                     if (state.selectedLanguages.isNotEmpty) ...[
// //                       Text(
// //                         'Selected Languages:',
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.grey.shade700,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Wrap(
// //                         spacing: 8,
// //                         children: state.selectedLanguages.map((language) {
// //                           return Chip(
// //                             avatar: Text(language.flag),
// //                             label: Text(language.name),
// //                             backgroundColor:
// //                                 Appcolors.kgreenlightColor.withOpacity(.3),
// //                             onDeleted: () {
// //                               context.read<LanguageSelectionBloc>().add(
// //                                     ToggleLanguageSelection(language),
// //                                   );
// //                             },
// //                           );
// //                         }).toList(),
// //                       ),
// //                       const SizedBox(height: 16),
// //                     ],
// //                     ElevatedButton(
// //                       onPressed: state.canSubmit
// //                           ? () {
// //                               // Navigator.push(
// //                               //   context,
// //                               //   MaterialPageRoute(
// //                               //     builder: (context) => NextPage(
// //                               //       selectedLanguages: state.selectedLanguages,
// //                               //     ),
// //                               //   ),
// //                               // );
// //                             }
// //                           : null,
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: state.canSubmit
// //                             ? Appcolors.korangeColor
// //                             : Colors.grey,
// //                         foregroundColor: Colors.white,
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 32,
// //                           vertical: 12,
// //                         ),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                       child: const Text(
// //                         'Continue',
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // ///////////////////////////
// // class LanguageData {
// //   static const List<Language> languages = [
// //     Language(
// //       code: 'en',
// //       name: 'English',
// //       nativeName: 'English',
// //       flag: '🇺🇸',
// //     ),
// //     Language(
// //       code: 'es',
// //       name: 'Spanish',
// //       nativeName: 'Español',
// //       flag: '🇪🇸',
// //     ),
// //     Language(
// //       code: 'fr',
// //       name: 'French',
// //       nativeName: 'Français',
// //       flag: '🇫🇷',
// //     ),
// //     Language(
// //       code: 'de',
// //       name: 'German',
// //       nativeName: 'Deutsch',
// //       flag: '🇩🇪',
// //     ),
// //     Language(
// //       code: 'it',
// //       name: 'Italian',
// //       nativeName: 'Italiano',
// //       flag: '🇮🇹',
// //     ),
// //     Language(
// //       code: 'pt',
// //       name: 'Portuguese',
// //       nativeName: 'Português',
// //       flag: '🇵🇹',
// //     ),
// //     Language(
// //       code: 'ru',
// //       name: 'Russian',
// //       nativeName: 'Русский',
// //       flag: '🇷🇺',
// //     ),
// //     Language(
// //       code: 'ja',
// //       name: 'Japanese',
// //       nativeName: '日本語',
// //       flag: '🇯🇵',
// //     ),
// //     Language(
// //       code: 'ko',
// //       name: 'Korean',
// //       nativeName: '한국어',
// //       flag: '🇰🇷',
// //     ),
// //     Language(
// //       code: 'zh',
// //       name: 'Chinese',
// //       nativeName: '中文',
// //       flag: '🇨🇳',
// //     ),
// //     Language(
// //       code: 'ar',
// //       name: 'Arabic',
// //       nativeName: 'العربية',
// //       flag: '🇸🇦',
// //     ),
// //     Language(
// //       code: 'hi',
// //       name: 'Hindi',
// //       nativeName: 'हिन्दी',
// //       flag: '🇮🇳',
// //     ),
// //   ];
// // }
// ////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/blocs/fetch_languages_bloc/fetch_languages_bloc.dart';
import 'package:langlex/data/models/language_model.dart';
import 'package:langlex/presentation/screens/screen_student_registration/screen_registrationpage.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

// class LanguageSelectionPage extends StatefulWidget {
//   const LanguageSelectionPage({super.key});

//   @override
//   State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
// }

// class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
//   List<LanguageModel> selectedLanguages = [];

//   @override
//   void initState() {
//     super.initState();
//     context.read<FetchLanguagesBloc>().add(FetchLanguagesInitialEvent());
//   }

//   void _toggleLanguageSelection(LanguageModel language) {
//     setState(() {
//       final existingIndex = selectedLanguages.indexWhere(
//         (selected) => selected.languageId == language.languageId,
//       );

//       if (existingIndex != -1) {
//         // Language is already selected, remove it
//         selectedLanguages.removeAt(existingIndex);
//       } else if (selectedLanguages.length < 3) {
//         // Language is not selected and we haven't reached the limit, add it
//         selectedLanguages.add(language);
//       }
//     });
//   }

//   void _resetSelection() {
//     setState(() {
//       selectedLanguages.clear();
//     });
//   }

//   bool get _isMaxSelected => selectedLanguages.length >= 3;
//   bool get _canSubmit => selectedLanguages.length == 3;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextStyles.subheadline(
//             text: 'Select Languages', color: Appcolors.kwhiteColor),
//         backgroundColor: Appcolors.kprimarycolor,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               _resetSelection();
//               context.read<FetchLanguagesBloc>().add(FetchLanguagesInitialEvent());
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<FetchLanguagesBloc, FetchLanguagesState>(
//         builder: (context, fetchState) {
//           if (fetchState is FetchLanguagesLoadingState) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (fetchState is FetchLanguagesErrorState) {
//             return _buildErrorState(fetchState.message);
//           } else if (fetchState is FetchLanguagesSuccessState) {
//             return _buildSuccessState(fetchState.languages);
//           } else {
//             return const Center(
//               child: Text('No languages available'),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildErrorState(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 64,
//             color: Colors.red.shade400,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Error loading languages',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.red.shade600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             message,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               context.read<FetchLanguagesBloc>().add(FetchLanguagesInitialEvent());
//             },
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSuccessState(List<LanguageModel> languages) {
//     return Column(
//       children: [
//         // Selection Counter
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           margin: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Appcolors.korangelightColor.withOpacity(.5),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Appcolors.korangeColor),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 'Select exactly 3 languages',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Appcolors.kprimarycolor,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${selectedLanguages.length}/3 selected',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Appcolors.kprimarycolor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Language List
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: languages.length,
//             itemBuilder: (context, index) {
//               final language = languages[index];
//               final isSelected = selectedLanguages.any(
//                 (selected) => selected.languageId == language.languageId
//               );
//               final canSelect = !_isMaxSelected || isSelected;

//               return Card(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 elevation: isSelected ? 4 : 1,
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: isSelected
//                         ? Colors.blue
//                         : Colors.grey.shade200,
//                     child: _buildLanguageImage(language),
//                   ),
//                   title: Text(
//                     language.languageName,
//                     style: TextStyle(
//                       fontWeight: isSelected
//                           ? FontWeight.bold
//                           : FontWeight.normal,
//                       color: canSelect ? Colors.black : Colors.grey,
//                     ),
//                   ),
//                   subtitle: Text(
//                     language.isoCode.toUpperCase(),
//                     style: TextStyle(
//                       color: canSelect
//                           ? Colors.grey.shade600
//                           : Colors.grey.shade400,
//                     ),
//                   ),
//                   trailing: isSelected
//                       ? Icon(
//                           Icons.check_circle,
//                           color: Colors.green.shade600,
//                         )
//                       : canSelect
//                           ? Icon(
//                               Icons.circle_outlined,
//                               color: Colors.grey.shade400,
//                             )
//                           : Icon(
//                               Icons.block,
//                               color: Colors.grey.shade300,
//                             ),
//                   onTap: canSelect
//                       ? () => _toggleLanguageSelection(language)
//                       : null,
//                   tileColor: isSelected
//                       ? Colors.blue.shade50
//                       : canSelect
//                           ? Colors.white
//                           : Colors.grey.shade50,
//                 ),
//               );
//             },
//           ),
//         ),
//         // Selected Languages and Submit Button
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               if (selectedLanguages.isNotEmpty) ...[
//                 Text(
//                   'Selected Languages:',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey.shade700,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Wrap(
//                   spacing: 8,
//                   children: selectedLanguages.map((language) {
//                     return Chip(
//                       avatar: _buildLanguageImage(language),
//                       label: Text(language.languageName),
//                       backgroundColor:
//                           Appcolors.kgreenlightColor.withOpacity(.3),
//                       onDeleted: () => _toggleLanguageSelection(language),
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//               ElevatedButton(
//                 onPressed: _canSubmit
//                     ? () {
//                         // Handle submission
//                         _handleSubmit();
//                       }
//                     : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _canSubmit
//                       ? Appcolors.korangeColor
//                       : Colors.grey,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Continue',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLanguageImage(LanguageModel language) {
//     if (language.languagePicture != null && language.languagePicture.isNotEmpty) {
//       return ClipOval(
//         child: Image.network(
//           language.languagePicture,
//           width: 32,
//           height: 32,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             return _buildLanguageIcon(language);
//           },
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) return child;
//             return const SizedBox(
//               width: 32,
//               height: 32,
//               child: CircularProgressIndicator(strokeWidth: 2),
//             );
//           },
//         ),
//       );
//     } else {
//       return _buildLanguageIcon(language);
//     }
//   }

//   Widget _buildLanguageIcon(LanguageModel language) {
//     return Text(
//       language.languageName.substring(0, 2).toUpperCase(),
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//     );
//   }

//   void _handleSubmit() {
//     // You can access selectedLanguages here
//     print('Selected languages: ${selectedLanguages.map((l) => l.languageName).join(', ')}');

//     // Navigate to next screen or perform other actions
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => NextPage(selectedLanguages: selectedLanguages),
//     //   ),
//     // );
//   }
// }
class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  // List<LanguageModel> selectedLanguages = [];
  List<LanguageModel> selectedLanguages = [];
  @override
  void initState() {
    super.initState();
    context.read<FetchLanguagesBloc>().add(FetchLanguagesInitialEvent());
  }

  void _toggleLanguageSelection(LanguageModel language) {
    setState(() {
      final existingIndex = selectedLanguages.indexWhere(
        (selected) => selected.languageId == language.languageId,
      );

      if (existingIndex != -1) {
        selectedLanguages.removeAt(existingIndex);
      } else if (selectedLanguages.length < 3) {
        selectedLanguages.add(language);
      }
    });
  }

  void _resetSelection() {
    setState(() {
      selectedLanguages.clear();
    });
  }

  bool get _isMaxSelected => selectedLanguages.length >= 3;
  bool get _canSubmit => selectedLanguages.length == 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Appcolors.kprimarycolor,
                Appcolors.kprimarycolor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: TextStyles.subheadline(
            text: 'Select Languages', color: Appcolors.kwhiteColor),
        foregroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _resetSelection();
                context
                    .read<FetchLanguagesBloc>()
                    .add(FetchLanguagesInitialEvent());
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<FetchLanguagesBloc, FetchLanguagesState>(
        builder: (context, fetchState) {
          if (fetchState is FetchLanguagesLoadingState) {
            return _buildLoadingState();
          } else if (fetchState is FetchLanguagesErrorState) {
            return _buildErrorState(fetchState.message);
          } else if (fetchState is FetchLanguagesSuccessState) {
            return _buildSuccessState(fetchState.languages);
          } else {
            return _buildEmptyState();
          }
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.kbackgroundcolor,
            Appcolors.kbackgroundcolor.withOpacity(0.9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Appcolors.kwhiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.kprimarycolor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Appcolors.kprimarycolor),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Loading languages...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Appcolors.ktextColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.kbackgroundcolor,
            Appcolors.kbackgroundcolor.withOpacity(0.9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Appcolors.kwhiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.kprimarycolor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.language_outlined,
                size: 48,
                color: Appcolors.kprimarycolor.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No languages available',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Appcolors.ktextColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.kbackgroundcolor,
            Appcolors.kbackgroundcolor.withOpacity(0.9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Appcolors.kwhiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Appcolors.kredcolor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Appcolors.kredcolor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Appcolors.kredcolor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Error loading languages',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Appcolors.kredcolor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Appcolors.khinttextColor,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<FetchLanguagesBloc>()
                      .add(FetchLanguagesInitialEvent());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.kredcolor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessState(List<LanguageModel> languages) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.kbackgroundcolor,
            Appcolors.kbackgroundcolor.withOpacity(0.9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // Enhanced Selection Counter
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Appcolors.korangelightColor.withOpacity(0.3),
                  Appcolors.korangedoublelightColor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Appcolors.korangeColor.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.korangeColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.language,
                      color: Appcolors.korangeColor,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Select exactly 3 languages',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.korangeColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Appcolors.korangeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${selectedLanguages.length}/3 selected',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Appcolors.korangeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Enhanced Language List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected = selectedLanguages.any(
                    (selected) => selected.languageId == language.languageId);
                final canSelect = !_isMaxSelected || isSelected;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              Appcolors.kgreenlightColor.withOpacity(0.2),
                              Appcolors.kgreenlightColor.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : Appcolors.kwhiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Appcolors.kgreenlightColor
                          : canSelect
                              ? Appcolors.kprimarycolor.withOpacity(0.2)
                              : Appcolors.kgreycolor.withOpacity(0.3),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? Appcolors.kgreenlightColor.withOpacity(0.3)
                            : Appcolors.kprimarycolor.withOpacity(0.1),
                        blurRadius: isSelected ? 12 : 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [
                                  Appcolors.kgreenlightColor,
                                  Appcolors.kprimarycolor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Appcolors.kgreycolor.withOpacity(0.3),
                                  Appcolors.kgreycolor.withOpacity(0.2),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? Appcolors.kgreenlightColor.withOpacity(0.3)
                                : Appcolors.kgreycolor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _buildLanguageImage(language),
                    ),
                    title: Text(
                      language.languageName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: canSelect
                            ? Appcolors.ktextColor
                            : Appcolors.kgreycolor,
                      ),
                    ),
                    subtitle: Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Appcolors.kgreenlightColor.withOpacity(0.2)
                            : Appcolors.kgreycolor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        language.isoCode.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: canSelect
                              ? Appcolors.kprimarycolor
                              : Appcolors.kgreycolor,
                        ),
                      ),
                    ),
                    trailing: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Appcolors.kgreenlightColor
                            : canSelect
                                ? Appcolors.kprimarycolor.withOpacity(0.1)
                                : Appcolors.kgreycolor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isSelected
                            ? Icons.check_circle
                            : canSelect
                                ? Icons.circle_outlined
                                : Icons.block,
                        color: isSelected
                            ? Appcolors.kwhiteColor
                            : canSelect
                                ? Appcolors.kprimarycolor
                                : Appcolors.kgreycolor,
                        size: 20,
                      ),
                    ),
                    onTap: canSelect
                        ? () => _toggleLanguageSelection(language)
                        : null,
                  ),
                );
              },
            ),
          ),
          // Enhanced Selected Languages and Submit Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Appcolors.kwhiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.kprimarycolor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedLanguages.isNotEmpty) ...[
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Appcolors.korangeColor,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Selected Languages:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.ktextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedLanguages.map((language) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Appcolors.kgreenlightColor.withOpacity(0.3),
                              Appcolors.kgreenlightColor.withOpacity(0.2),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Appcolors.kgreenlightColor.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildLanguageImage(language),
                            const SizedBox(width: 8),
                            Text(
                              language.languageName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Appcolors.ktextColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => _toggleLanguageSelection(language),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Appcolors.kredcolor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Appcolors.kredcolor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: _canSubmit
                        ? LinearGradient(
                            colors: [
                              Appcolors.korangeColor,
                              Appcolors.korangeColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: _canSubmit
                        ? null
                        : Appcolors.kgreycolor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _canSubmit
                        ? [
                            BoxShadow(
                              color: Appcolors.korangeColor.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _handleSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_canSubmit) ...[
                          const Icon(Icons.arrow_forward, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _canSubmit
                                ? Colors.white
                                : Appcolors.kgreycolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageImage(LanguageModel language) {
    if (language.languagePicture != null &&
        language.languagePicture.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          language.languagePicture,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildLanguageIcon(language);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Appcolors.kgreycolor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Appcolors.kprimarycolor),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return _buildLanguageIcon(language);
    }
  }

  Widget _buildLanguageIcon(LanguageModel language) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          language.languageName.substring(0, 2).toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    List<int> selectedLanguageIds =
        selectedLanguages.map((lang) => lang.languageId).toList();

    print('Selected language IDs: $selectedLanguageIds');
    CustomNavigation.pushReplaceWithTransition(
        context,
        ScreenStudentRegistration(
          selectedLanguages: selectedLanguageIds,
        ));

  }
}
