import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

import 'package:langlex/presentation/cubits/language_change.dart';
import 'package:langlex/presentation/screens/languagepage/widgets/customlanguage_container.dart';
import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLanguagePage extends StatefulWidget {
  ScreenLanguagePage({super.key});

  @override
  State<ScreenLanguagePage> createState() => _ScreenLanguagePageState();
}

class _ScreenLanguagePageState extends State<ScreenLanguagePage> {
  Map<String, String> buttonlanguages = {};

  List localCodes = [];
  int currentIndex = 0;
  final List<Map<String, String>> languages = [
    {'English': 'en'},
    {'हिन्दी': 'hi'},
    {'ಕನ್ನಡ': 'ka'},
    {'தமிழ்': 'ta'},
    {'मराठी': 'mr'}
  ];

  @override
  void initState() {
    super.initState();
    _checkLanguageSelection();
    loadStoredlanguages();
  }

  Future<void> loadStoredlanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedlanguages = prefs.getStringList('SELECTEDLANGUAGES');
    setState(() {
      if (storedlanguages != null && storedlanguages.isNotEmpty) {
        localCodes = storedlanguages;
      } else {
        localCodes = ["en", "hi", "ka"];
      }
      buttonlanguages.clear();
      for (var code in localCodes) {
        for (var language in languages) {
          if (language.values.first == code) {
            buttonlanguages[language.keys.first] = language.values.first;
          }
        }
      }
    });
  }

  Future<void> _checkLanguageSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selectedLanguage');
    if (selectedLanguage != null) {
      context.read<LanguageCubit>().changeLanguage(selectedLanguage);
      Locales.change(context, selectedLanguage);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Screenmainpage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .15,
            image: AssetImage(
                profilebackgroundimage), // Correct way to use asset image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: h(context) * .15,
            ),
            Text(
              'Choose Language',
              style: TextStyle(
                  color: Appcolors.kgreenColor,
                  fontSize: AppDimensions.fontSize25(context),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h(context) * .05,
            ),
            // Wrapping ListView.builder with Flexible to avoid overflow
            Flexible(
              child: ListView.builder(
                itemCount: buttonlanguages.length,
                itemBuilder: (context, index) {
                  String languageKey = buttonlanguages.keys.elementAt(index);
                  return InkWell(
                    onTap: () async {
                      currentIndex = index;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                          'selectedLanguage', localCodes[index]);
                      // ignore: use_build_context_synchronously
                      context
                          .read<LanguageCubit>()
                          .changeLanguage(localCodes[index]);
                      // ignore: use_build_context_synchronously
                      Locales.change(context, localCodes[index]);
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screenmainpage()),
                      );
                    },
                    child: CustomLanguageContainer(
                      languageText: languageKey,
                      heroTag: localCodes[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
