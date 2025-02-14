// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_locales/flutter_locales.dart';

// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';

// import 'package:langlex/presentation/cubits/language_change.dart';
// import 'package:langlex/presentation/screens/languagepage/widgets/customlanguage_container.dart';
// import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ScreenLanguagePage extends StatefulWidget {
//   ScreenLanguagePage({super.key});

//   @override
//   State<ScreenLanguagePage> createState() => _ScreenLanguagePageState();
// }

// class _ScreenLanguagePageState extends State<ScreenLanguagePage> {
//   Map<String, String> buttonlanguages = {};

//   List localCodes = [];
//   int currentIndex = 0;
//   final List<Map<String, String>> languages = [
//     {'English': 'en'},
//     {'हिन्दी': 'hi'},
//     {'ಕನ್ನಡ': 'ka'},
//     {'தமிழ்': 'ta'},
//     {'मराठी': 'mr'}
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _checkLanguageSelection();
//     loadStoredlanguages();
//   }

//   Future<void> loadStoredlanguages() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? storedlanguages = prefs.getStringList('SELECTEDLANGUAGES');
//     setState(() {
//       if (storedlanguages != null && storedlanguages.isNotEmpty) {
//         localCodes = storedlanguages;
//       } else {
//         localCodes = ["en", "hi", "ka"];
//       }
//       buttonlanguages.clear();
//       for (var code in localCodes) {
//         for (var language in languages) {
//           if (language.values.first == code) {
//             buttonlanguages[language.keys.first] = language.values.first;
//           }
//         }
//       }
//     });
//   }

//   Future<void> _checkLanguageSelection() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? selectedLanguage = prefs.getString('selectedLanguage');
//     if (selectedLanguage != null) {
//       context.read<LanguageCubit>().changeLanguage(selectedLanguage);
//       Locales.change(context, selectedLanguage);
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => Screenmainpage()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             opacity: .15,
//             image: AssetImage(
//                 profilebackgroundimage), // Correct way to use asset image
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: h(context) * .15,
//             ),
//             Text(
//               'Choose Language',
//               style: TextStyle(
//                   color: Appcolors.kgreenColor,
//                   fontSize: AppDimensions.fontSize25(context),
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: h(context) * .05,
//             ),
//             // Wrapping ListView.builder with Flexible to avoid overflow
//             Flexible(
//               child: ListView.builder(
//                 itemCount: buttonlanguages.length,
//                 itemBuilder: (context, index) {
//                   String languageKey = buttonlanguages.keys.elementAt(index);
//                   return InkWell(
//                     onTap: () async {
//                       currentIndex = index;
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       await prefs.setString(
//                           'selectedLanguage', localCodes[index]);
//                       // ignore: use_build_context_synchronously
//                       context
//                           .read<LanguageCubit>()
//                           .changeLanguage(localCodes[index]);
//                       // ignore: use_build_context_synchronously
//                       Locales.change(context, localCodes[index]);
//                       Navigator.pushReplacement(
//                         // ignore: use_build_context_synchronously
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Screenmainpage()),
//                       );
//                     },
//                     child: CustomLanguageContainer(
//                       languageText: languageKey,
//                       heroTag: localCodes[index],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class StaticWaveClipper extends CustomClipper<Path> {
//   final int waveLayer;

//   StaticWaveClipper(this.waveLayer);

//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, size.height); // Start from bottom left

//     double x = 0;
//     double y = 0;

//     // Enhanced wave parameters with more organic variation
//     double amplitude = waveLayer == 1
//         ? 80
//         : waveLayer == 2
//             ? 60
//             : 40;

//     // Adjust frequency for more interesting wave patterns
//     double frequency = size.height /
//         (waveLayer == 1
//             ? 3.0
//             : waveLayer == 2
//                 ? 3.5
//                 : 4.0);

//     // Varied phase shifts for layer depth
//     double phase = waveLayer == 1
//         ? 0
//         : waveLayer == 2
//             ? math.pi / 3
//             : math.pi / 1.5;

//     // Draw vertical wave path from bottom to top
//     while (y < size.height * 1.2) {
//       x = amplitude * math.sin((y / frequency) + phase);
//       path.lineTo(size.width * 0.5 + x, size.height - y);
//       y += 1;
//     }

//     // Close the path
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
//////////////////////////////
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

import 'package:langlex/presentation/cubits/language_change.dart';
import 'package:langlex/presentation/screens/languagepage/widgets/customlanguage_container.dart';
import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';

class DiagonalWaveClipper extends CustomClipper<Path> {
  final int waveLayer;

  DiagonalWaveClipper(this.waveLayer);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height); // Start from bottom left

    double x = 0;
    double y = 0;

    // More sophisticated wave parameters
    double amplitude = waveLayer == 1
        ? 100
        : waveLayer == 2
            ? 75
            : 50;

    // Adjust frequency for more interesting wave patterns
    double frequency = size.width /
        (waveLayer == 1
            ? 2.5
            : waveLayer == 2
                ? 3.0
                : 3.5);

    // Varied phase shifts for layer depth and diagonal movement
    double phase = waveLayer == 1
        ? 0
        : waveLayer == 2
            ? math.pi / 4
            : math.pi / 2;

    // Draw diagonal wave path from bottom left to top right
    while (x < size.width * 1.2) {
      // Create a more organic, diagonal wave progression
      double wavey = amplitude * math.sin((x / frequency) + phase);
      path.lineTo(x, size.height - y + wavey);

      x += 2;
      y += 1.5; // Slightly slower vertical progression
    }

    // Close the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DiagonalWaveBackground extends StatelessWidget {
  final Widget child;

  const DiagonalWaveBackground({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Wave layers
        for (int i = 1; i <= 3; i++)
          Positioned.fill(
            child: ClipPath(
              clipper: DiagonalWaveClipper(i),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      if (i == 1) ...[
                        Appcolors.kgreenColor,
                        Appcolors.kblackColor,
                      ] else if (i == 2) ...[
                        Colors.green.shade200.withOpacity(0.5),
                        Colors.white.withOpacity(0.6),
                      ] else ...[
                        Appcolors.kpurplecolor.withOpacity(0.3),
                        Colors.white.withOpacity(0.2),
                      ]
                    ],
                    stops: [0.2, 0.8], // More concentrated gradient
                  ),
                ),
              ),
            ),
          ),

        // Subtle overlay for additional depth
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        // Original content
        child,
      ],
    );
  }
}

class ScreenLanguagePage extends StatefulWidget {
  const ScreenLanguagePage({super.key});

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
      body: DiagonalWaveBackground(
        child: Column(
          children: [
            SizedBox(
              height: ResponsiveUtils.hp(13),
            ),
            Image.asset(
              logo,
              fit: BoxFit.contain,
              height: ResponsiveUtils.hp(15),
              width: ResponsiveUtils.wp(30),
            ),
            ResponsiveSizedBox.height20,
            TextStyles.subheadline(
                color: Appcolors.kgreenColor,
                text: 'Choose Language',
                weight: FontWeight.bold),
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
