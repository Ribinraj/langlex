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
  List locales = ["English", "हिन्दी", "ಕನ್ನಡ"];
  List localCodes = ["en", "hi", "ka"];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkLanguageSelection();
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
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Appcolors.kgreenlightColor, // Start color (bottom)
              Appcolors.kbackgroundcolor, // End color (top)
            ],
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
                  color: Appcolors.ktextColor,
                  fontSize: AppDimensions.fontSize30(context),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: h(context) * .05,
            ),
            // Wrapping ListView.builder with Flexible to avoid overflow
            Flexible(
              child: ListView.builder(
                itemCount: locales.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      currentIndex = index;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                          'selectedLanguage', localCodes[index]);
                      context
                          .read<LanguageCubit>()
                          .changeLanguage(localCodes[index]);
                      Locales.change(context, localCodes[index]);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screenmainpage()),
                      );
                    },
                    child: CustomLanguageContainer(languageText: locales[index],heroTag: localCodes[index],),
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
