// import 'dart:ffi';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';
// import 'package:langlex/presentation/widgets/custom_snakebar.dart';
// import 'package:langlex/presentation/widgets/custom_squre_elevatedbutton.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LanguageSelectionSheet extends StatefulWidget {
//   const LanguageSelectionSheet({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   LanguageSelectionSheetState createState() => LanguageSelectionSheetState();
// }

// class LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
//   // List of available languages
//   final List<Map<String, String>> languages = [
//     {'English': 'en'},
//     {'हिन्दी': 'hi'},
//     {'ಕನ್ನಡ': 'ka'},
//     {'தமிழ்': 'ta'},
//     {'मराठी': 'mr'}
//   ];

//   // Set to store the selected languages, initialized with 'en', 'hi', and 'ka'
//   Set<String> selectedLanguages = {};

//   Future<void> loadSelectedLanguages() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? storedLanguages = prefs.getStringList('SELECTEDLANGUAGES');
//     setState(() {
//       if (storedLanguages == null || storedLanguages.isEmpty) {
//         selectedLanguages = {'en', 'hi', 'ka'};
//       } else {
//         selectedLanguages = selectedLanguages.toSet();
//       }
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadSelectedLanguages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(
//               CupertinoIcons.back,
//               color: Appcolors.kwhiteColor,
//             )),
//         title: const Text(
//           'Select Languages',
//           style: TextStyle(color: Appcolors.kwhiteColor),
//         ),
//         centerTitle: true,
//         backgroundColor: Appcolors.kgreenColor,
//       ),
//       body: Container(
//         height: double.infinity,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(profilebackgroundimage),
//                 fit: BoxFit.cover,
//                 opacity: .15)),
//         child: Column(
//           children: [
//             Expanded(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(16),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // Display two items per row
//                   childAspectRatio: 1, // Square container aspect ratio
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 16,
//                 ),
//                 itemCount: languages.length,
//                 itemBuilder: (context, index) {
//                   String languageName = languages[index].keys.first;
//                   String languageCode = languages[index].values.first;
//                   bool isSelected = selectedLanguages.contains(languageCode);

//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (isSelected) {
//                           selectedLanguages.remove(languageCode);
//                         } else if (selectedLanguages.length < 3) {
//                           selectedLanguages.add(languageCode);
//                         } else {
//                           customSnackbar(
//                               context,
//                               'You can select upto 3 languages',
//                               Appcolors.kredcolor);
//                         }
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: isSelected
//                             ? Appcolors.kgreenColor.withOpacity(0.2)
//                             : Colors.white,
//                         border: Border.all(
//                           color: isSelected ? Colors.green : Colors.grey,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Stack(
//                         children: [
//                           Center(
//                             child: Text(
//                               languageName,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           if (isSelected)
//                             const Positioned(
//                               top: 8,
//                               right: 8,
//                               child: Icon(
//                                 Icons.check_circle,
//                                 color: Colors.green,
//                                 size: 24,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CustomSqureElevatedButton(
//                     onPressed: () {
//                       if (selectedLanguages.length == 3) {
//                         storeSelectedlanguages();
//                         Navigator.pop(context, selectedLanguages.toList());
//                       }
//                       // Return selected languages to the parent widget
//                       else {
//                         customSnackbar(context, 'please select three languages',
//                             Appcolors.kredcolor);
//                       }
//                     },
//                     buttonText: 'Submit',
//                     backgroundcolor: Appcolors.kgreenColor)),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> storeSelectedlanguages() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('SELECTEDLANGUAGES', selectedLanguages.toList());

//     customSnackbar(
//         context, 'Languages saved successfully', Appcolors.kgreenColor);
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/widgets/custom_snakebar.dart';
import 'package:langlex/presentation/widgets/custom_squre_elevatedbutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  LanguageSelectionSheetState createState() => LanguageSelectionSheetState();
}

class LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  // List of available languages
  final List<Map<String, String>> languages = [
    {'English': 'en'},
    {'हिन्दी': 'hi'},
    {'ಕನ್ನಡ': 'ka'},
    {'தமிழ்': 'ta'},
    {'मराठी': 'mr'}
  ];

  // Set to store the selected languages
  Set<String> selectedLanguages = {};

  @override
  void initState() {
    super.initState();
    // Load the selected languages when the widget is initialized
    loadSelectedLanguages();
  }

  // Function to load stored languages or initialize default languages
  Future<void> loadSelectedLanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedLanguages = prefs.getStringList('SELECTEDLANGUAGES');

    setState(() {
      // If no languages are stored, use the default ones
      if (storedLanguages == null || storedLanguages.isEmpty) {
        selectedLanguages = {'en', 'hi', 'ka'};
      } else {
        // If there are stored languages, populate the set with them
        selectedLanguages = storedLanguages.toSet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Appcolors.kwhiteColor,
            )),
        title: const Text(
          'Select Languages',
          style: TextStyle(color: Appcolors.kwhiteColor),
        ),
        centerTitle: true,
        backgroundColor: Appcolors.kgreenColor,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(profilebackgroundimage),
                fit: BoxFit.cover,
                opacity: .15)),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Display three items per row
                  childAspectRatio: 1, // Square container aspect ratio
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  String languageName = languages[index].keys.first;
                  String languageCode = languages[index].values.first;
                  bool isSelected = selectedLanguages.contains(languageCode);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedLanguages.remove(languageCode);
                        } else if (selectedLanguages.length < 3) {
                          selectedLanguages.add(languageCode);
                        } else {
                          customSnackbar(
                              context,
                              'You can select up to 3 languages',
                              Appcolors.kredcolor);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Appcolors.kgreenColor.withOpacity(0.2)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              languageName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 24,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSqureElevatedButton(
                    onPressed: () {
                      if (selectedLanguages.length == 3) {
                        storeSelectedLanguages();
                        Navigator.pop(context, selectedLanguages.toList());
                      } else {
                        customSnackbar(
                            context,
                            'Please select three languages',
                            Appcolors.kredcolor);
                      }
                    },
                    buttonText: 'Submit',
                    backgroundcolor: Appcolors.kgreenColor)),
          ],
        ),
      ),
    );
  }

  Future<void> storeSelectedLanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('SELECTEDLANGUAGES', selectedLanguages.toList());

    customSnackbar(
        context, 'Languages saved successfully', Appcolors.kgreenColor);
  }
}
