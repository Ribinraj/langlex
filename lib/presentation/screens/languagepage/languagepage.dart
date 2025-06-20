

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

import 'package:langlex/presentation/cubits/language_change.dart';
import 'package:langlex/presentation/screens/languagepage/widgets/customlanguage_container.dart';
import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';


// class ScreenLanguagePage extends StatefulWidget {
//   const ScreenLanguagePage({super.key});

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
//       backgroundColor: Appcolors.kbackgroundcolor,
//       body: Column(
//         children: [
//           Container(
//               height: ResponsiveUtils.hp(50),
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Appcolors.kgreenColor,
//                       Color.fromARGB(255, 99, 233, 179)
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15))),
//               child: Column(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.asset(
//                       'assets/images/3-d-illustration-abc-sign-icon.png',
//                       height: ResponsiveUtils.hp(28),
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   ResponsiveSizedBox.height50,
//                   Text(
//                     "Choose Language",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.fredoka(
//                       fontSize: ResponsiveUtils.wp(6),
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 3.0,
//                           color: Colors.black.withOpacity(0.5),
//                           offset: Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ResponsiveSizedBox.height50,
//                 ],
//               )),
//           ResponsiveSizedBox.height50,
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.85, // Adjust this value to control height
//                 ),
//                 itemCount: buttonlanguages.length,
//                 itemBuilder: (context, index) {
//                   String languageKey = buttonlanguages.keys.elementAt(index);
//                   return GestureDetector(
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
//           ),
//         ],
//       ),
//     );
//   }

// }
class ScreenLanguagePage extends StatefulWidget {
  const ScreenLanguagePage({super.key});

  @override
  State<ScreenLanguagePage> createState() => _ScreenLanguagePageState();
}

class _ScreenLanguagePageState extends State<ScreenLanguagePage>
    with TickerProviderStateMixin {
  Map<String, String> buttonlanguages = {};
  List localCodes = [];
  int currentIndex = 0;
  int? selectedIndex;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, String>> languages = [
    {'English': 'en'},
    {'हिन्दी': 'hi'},
    {'ಕನ್ನಡ': 'ka'},
    {'தமிழ்': 'ta'},
    {'मराठी': 'mr'}
  ];

  // Language icons/flags mapping
  final Map<String, String> languageIcons = {
    'English': '🇺🇸',
    'हिन्दी': '🇮🇳',
    'ಕನ್ನಡ': '🇮🇳',
    'தமிழ்': '🇮🇳',
    'मराठी': '🇮🇳',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _checkLanguageSelection();
    loadStoredlanguages();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 71, 158, 133), // kgreenColor
              Color.fromARGB(255, 107, 197, 172), // kgreenlightColor
              Color.fromARGB(255, 218, 147, 65), // korangeColor
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section with Enhanced Design
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Large Language Illustration
                      Image.asset(
                        'assets/images/3-d-illustration-abc-sign-icon.png',
                        height: ResponsiveUtils.hp(25),
                        width: ResponsiveUtils.wp(60),
                        fit: BoxFit.contain,
                      ),
                      
                      SizedBox(height: ResponsiveUtils.hp(3)),
                      
                      // Title with Beautiful Typography
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.white, Color(0xFFE3F2FD)],
                        ).createShader(bounds),
                        child: Text(
                          "Choose Your Language",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: ResponsiveUtils.wp(7),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: ResponsiveUtils.hp(1)),
                      
                      // Subtitle
                      Text(
                        "Select your preferred language to continue",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.wp(4),
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Language Grid Section
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Padding(
                        padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                        child: Column(
                          children: [
                            // Drag indicator
                            Container(
                              width: ResponsiveUtils.wp(15),
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 107, 197, 172).withOpacity(0.3), // kgreenlightColor
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            
                            SizedBox(height: ResponsiveUtils.hp(3)),
                            
                            // Grid of Language Options
                            Expanded(
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: ResponsiveUtils.wp(4),
                                  mainAxisSpacing: ResponsiveUtils.hp(2),
                                  childAspectRatio: 1.2,
                                ),
                                itemCount: buttonlanguages.length,
                                itemBuilder: (context, index) {
                                  String languageKey = buttonlanguages.keys.elementAt(index);
                                  bool isSelected = selectedIndex == index;
                                  
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          selectedIndex = index;
                                          currentIndex = index;
                                        });
                                        
                                        // Add haptic feedback
                                        HapticFeedback.lightImpact();
                                        
                                        // Delay for animation
                                        await Future.delayed(const Duration(milliseconds: 200));
                                        
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.setString('selectedLanguage', localCodes[index]);
                                        
                                        // ignore: use_build_context_synchronously
                                        context.read<LanguageCubit>().changeLanguage(localCodes[index]);
                                        // ignore: use_build_context_synchronously
                                        Locales.change(context, localCodes[index]);
                                        
                                        Navigator.pushReplacement(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) => Screenmainpage(),
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              return FadeTransition(opacity: animation, child: child);
                                            },
                                            transitionDuration: const Duration(milliseconds: 500),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: isSelected
                                              ? const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(255, 71, 158, 133), // kgreenColor
                                                    Color.fromARGB(255, 107, 197, 172), // kgreenlightColor
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : LinearGradient(
                                                  colors: [Colors.grey[50]!, Colors.white],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected 
                                                ? Colors.transparent 
                                                : Colors.grey[300]!,
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: isSelected
                                                  ? const Color.fromARGB(255, 71, 158, 133).withOpacity(0.3)
                                                  : Colors.grey.withOpacity(0.1),
                                              blurRadius: isSelected ? 15 : 8,
                                              offset: Offset(0, isSelected ? 8 : 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Language Flag/Icon
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? Colors.white.withOpacity(0.2)
                                                    : Colors.grey[100],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                languageIcons[languageKey] ?? '🌐',
                                                style: TextStyle(
                                                  fontSize: ResponsiveUtils.wp(8),
                                                ),
                                              ),
                                            ),
                                            
                                            SizedBox(height: ResponsiveUtils.hp(1)),
                                            
                                            // Language Name
                                            Text(
                                              languageKey,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                fontSize: ResponsiveUtils.wp(4.5),
                                                fontWeight: FontWeight.w600,
                                                color: isSelected 
                                                    ? Colors.white 
                                                    : const Color.fromARGB(255, 35, 31, 32), // ktextColor
                                              ),
                                            ),
                                            
                                            // Selection indicator
                                            if (isSelected)
                                              Container(
                                                margin: const EdgeInsets.only(top: 8),
                                                width: 6,
                                                height: 6,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}