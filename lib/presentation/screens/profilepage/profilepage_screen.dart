// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';
// import 'package:langlex/core/responsive_utils.dart';

// import 'package:langlex/presentation/screens/editprofile_page/editprofile.dart';

// import 'package:langlex/presentation/screens/profilepage/widgets/custom_profilecontainer.dart';
// import 'package:langlex/presentation/screens/quiz_screen/quiz_screen.dart';
// import 'package:langlex/presentation/screens/splashScreen/splashscreen.dart';
// import 'package:langlex/presentation/widgets/custom_navigation.dart';

// import 'package:langlex/presentation/widgets/custom_profile_image.dart';
// import 'package:langlex/presentation/widgets/navigate_mainpage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ScreenProfilePage extends StatelessWidget {
//   const ScreenProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Appcolors.kbackgroundcolor,
//         body: Stack(
//           children: [
//             Positioned.fill(
//               child: Opacity(
//                 opacity: 0.15,
//                 child: Image.asset(
//                   'assets/images/profilebackground.jpeg',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: ResponsiveUtils.hp(10),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                     // width: ResponsiveUtils.wp(80),
//                     height: ResponsiveUtils.hp(22),
//                     decoration: BoxDecoration(
//                       color: Appcolors.kgreycolor,
//                       gradient: const LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color.fromARGB(
//                               255, 220, 213, 213),
//                           Appcolors.kwhiteColor,
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                       // border: Border.all(
//                       //     width: .5,
//                       //     color: Appcolors.kgreenColor.withOpacity(.7))
//                     ),
//                     child: Row(
//                       children: [
//                         CustomRoundImage(
//                             circleContainerSize: ResponsiveUtils.wp(20),
//                             imageUrl:
//                                 'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png'),
//                         ResponsiveSizedBox.width30,
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextStyles.body(
//                               text: 'Ribinraj',
//                               weight: FontWeight.bold,
//                             ),
//                             ResponsiveSizedBox.height5,
//                             TextStyles.caption(
//                               text: 'ribinrajop@gmail.com',
//                               weight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   ResponsiveSizedBox.height30,
//                   Container(
//                     padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Appcolors.kwhiteColor,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             CustomNavigation.push(context, ScreenEditProfile());
//                           },
//                           child: const CustomProfileContainer(
//                             containerText: 'Edit profile',
//                             icon: CupertinoIcons.person,
//                           ),
//                         ),
//                         ResponsiveSizedBox.height20,
//                         InkWell(
//                           onTap: () {
//                             CustomNavigation.push(context, ScreenQuizPage());
//                           },
//                           child: CustomProfileContainer(
//                             containerText: 'My Courses',
//                             icon: CupertinoIcons.briefcase,
//                           ),
//                         ),
//                         ResponsiveSizedBox.height20,
//                         const CustomProfileContainer(
//                           containerText: 'Packages',
//                           icon: CupertinoIcons.collections,
//                         ),
//                         ResponsiveSizedBox.height20,
//                         const CustomProfileContainer(
//                           containerText: 'Privacy & Policy',
//                           icon: CupertinoIcons.exclamationmark_shield,
//                         ),
//                         ResponsiveSizedBox.height20,
//                         const CustomProfileContainer(
//                           containerText: 'About Us',
//                           icon: Icons.arrow_drop_down_circle_outlined,
//                         ),
//                         ResponsiveSizedBox.height20,
//                         InkWell(
//                           onTap: () {
//                             print('logout');
//                             _logout(context);
//                           },
//                           child: Container(
//                             height: ResponsiveUtils.hp(6),
//                             // width: ResponsiveUtils.wp(80),
//                             decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Color.fromARGB(255, 235, 228,
//                                         228), // Start color (bottom)
//                                     Appcolors.kwhiteColor, // End color (top)
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(5),
//                                 // borderRadius: const BorderRadius.only(
//                                 //     topLeft: Radius.circular(15),
//                                 //     bottomRight: Radius.circular(15)),
//                                 border: Border.all(
//                                     width: .5,
//                                     color:
//                                         Appcolors.kgreenColor.withOpacity(.7))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 12, right: 12),
//                               child: Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.logout_outlined,
//                                     color: Appcolors.kredcolor,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   TextStyles.medium(
//                                       text: 'Logout',
//                                       weight: FontWeight.bold,
//                                       color: Appcolors.kredcolor),
//                                   const Spacer(),
//                                   const Icon(
//                                     CupertinoIcons.chevron_forward,
//                                     color: Appcolors.kredcolor,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }

// //////
// Future<void> _logout(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('selectedLanguage');
//   navigateToMainPage(context, 0);
//   Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (context) => const SplashPage()),
//     (route) => false,
//   );
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';

import 'package:langlex/presentation/screens/editprofile_page/editprofile.dart';
import 'package:langlex/presentation/screens/loginpage/loginpage.dart';
import 'package:langlex/presentation/screens/quiz_screen/quiz_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

// class ScreenProfilePage extends StatelessWidget {
//   const ScreenProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FBFF),
//       body: Column(
//         children: [
//           // Top Profile Section with Wave Background
//           Stack(
//             children: [
//               Container(
//                 height: ResponsiveUtils.hp(35),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Appcolors.kprimarycolor,
//                       Color.fromARGB(255, 99, 233, 179)
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: ResponsiveUtils.wp(6),
//                     vertical: ResponsiveUtils.hp(6)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Profile and Menu Icon
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomRoundImage(
//                           circleContainerSize: ResponsiveUtils.wp(25),
//                           imageUrl:
//                               'https://anakoskaphotography.com/wp-content/uploads/2018/09/outdoor-children-photo-of-a-girl.jpg',
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             CustomNavigation.push(
//                                 context, const ScreenEditProfile());
//                           },
//                           child: const Icon(Icons.edit_square,
//                               color: Colors.white, size: 25),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: ResponsiveUtils.hp(2)),
//                     TextStyles.subheadline(
//                         text: 'Ribinraj',
//                         weight: FontWeight.bold,
//                         color: Appcolors.kwhiteColor),
//                     ResponsiveSizedBox.height5,
//                     TextStyles.caption(
//                         text: 'ribinrajop@gmail.com',
//                         weight: FontWeight.bold,
//                         color: Appcolors.kwhiteColor),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: ResponsiveUtils.hp(5)),

//           // Category Grid Section
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(5)),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: 6,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   childAspectRatio: 1.0,
//                   crossAxisSpacing: 15,
//                   mainAxisSpacing: 15,
//                 ),
//                 itemBuilder: (context, index) {
//                   List<Map<String, dynamic>> categories = [
//                     {
//                       'icon': CupertinoIcons.briefcase,
//                       'label': "My Courses",
//                       'page': const ScreenEditProfile()
//                     },
//                     {
//                       'icon': CupertinoIcons.collections,
//                       'label': "Packages",
//                       'page': const ScreenQuizPage()
//                     },
//                     {
//                       'icon': CupertinoIcons.exclamationmark_shield,
//                       'label': "Privacy Policy"
//                     },
//                     {
//                       'icon': Icons.arrow_drop_down_circle_outlined,
//                       'label': "About Us"
//                     },
//                     {'icon': Icons.format_paint, 'label': "Conditions"},
//                     {'icon': Icons.air, 'label': "Dry"},
//                   ];

//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => categories[index]['page']),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                             color: Colors.redAccent.withOpacity(0.5),
//                             width: 1.5),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 5,
//                             spreadRadius: 1,
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             categories[index]['icon'],
//                             size: ResponsiveUtils.wp(6),
//                             color: Colors.redAccent.withOpacity(.6),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             categories[index]['label'],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           // Logout Button
//           Row(
//             children: [
//               const Spacer(),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: ResponsiveUtils.wp(5),
//                     vertical: ResponsiveUtils.hp(3)),
//                 child: ElevatedButton.icon(
//                   onPressed: () => _logout(context),
//                   icon: const Icon(Icons.logout, color: Colors.white),
//                   label: const Text(
//                     "Logout",
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                         vertical: ResponsiveUtils.wp(1),
//                         horizontal: ResponsiveUtils.wp(4)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

// // Logout Function
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('selectedLanguage');

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => ScreenLoginpage()),
//       (route) => false,
//     );
//   }
// }

import 'dart:math' as math;

//Custom Wave Painter for the top section
//Custom Wave Painter for the top section with large waves
class WavePainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final double animationValue;

  WavePainter({
    required this.color1,
    required this.color2,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [color1, color2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final waveHeight =
        size.height * 0.12; // Increased wave height for larger waves
    final waveLength = size.width * 1.5; // Larger wave length for bigger waves

    path.moveTo(0, 0);
    path.lineTo(0, size.height - waveHeight);

    // Create large flowing wave pattern with smaller curves
    for (double x = 0; x <= size.width; x++) {
      final y = size.height -
          waveHeight +
          // Main large wave with smaller curve
          math.sin((x / waveLength) * 2 * math.pi + animationValue * 1.5) * 20 +
          // Secondary wave for subtle variation
          math.sin((x / (waveLength * 1.2)) * 1.5 * math.pi +
                  animationValue * 1.2) *
              8;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Enhanced Custom Painter for decorative elements with faster animation
class CircleDecorPainter extends CustomPainter {
  final double animationValue;

  CircleDecorPainter({this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Enhanced floating elements with faster movement
    final elements = [
      {
        'x': size.width * 0.85,
        'y': size.height * 0.15,
        'radius': 25.0,
        'speed': 1.2 // Increased speed
      },
      {
        'x': size.width * 0.12,
        'y': size.height * 0.65,
        'radius': 18.0,
        'speed': 1.6 // Increased speed
      },
      {
        'x': size.width * 0.88,
        'y': size.height * 0.75,
        'radius': 22.0,
        'speed': 0.9 // Increased speed
      },
      {
        'x': size.width * 0.25,
        'y': size.height * 0.08,
        'radius': 12.0,
        'speed': 1.8 // Increased speed
      },
      {
        'x': size.width * 0.65,
        'y': size.height * 0.35,
        'radius': 15.0,
        'speed': 1.3 // Increased speed
      },
      {
        'x': size.width * 0.05,
        'y': size.height * 0.25,
        'radius': 8.0,
        'speed': 2.0 // Increased speed
      },
    ];

    for (var element in elements) {
      final speed = element['speed'] as double;
      final offset = Offset(
        element['x']! +
            math.sin(animationValue * speed + element['y']! / 300) *
                6, // Increased movement range
        element['y']! +
            math.cos(animationValue * speed * 0.8 + element['x']! / 300) *
                4, // Increased movement range
      );

      // Draw filled circle
      canvas.drawCircle(offset, element['radius']! as double, paint);
      // Draw stroke circle for better definition
      canvas.drawCircle(offset, element['radius']! as double, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Also update the animation controller duration for faster animation
class ScreenProfilePage extends StatefulWidget {
  const ScreenProfilePage({super.key});

  @override
  State<ScreenProfilePage> createState() => _ScreenProfilePageState();
}

class _ScreenProfilePageState extends State<ScreenProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Faster wave animation - reduced from 15 seconds to 8 seconds
    _waveController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // Get categories with navigation pages
  List<Map<String, dynamic>> get categories => [
        {
          'icon': CupertinoIcons.book_fill,
          'label': "My Courses",
          'color': const Color(0xFF3B82F6),
          'page': const ScreenEditProfile() // Replace with your actual page
        },
        {
          'icon': CupertinoIcons.cube_box_fill,
          'label': "Packages",
          'color': const Color(0xFF8B5CF6),
          'page': const ScreenQuizPage() // Replace with your actual page
        },
        {
          'icon': CupertinoIcons.shield_lefthalf_fill,
          'label': "Privacy",
          'color': const Color(0xFFF59E0B),
          'page': null // No page navigation for this item
        },
        {
          'icon': CupertinoIcons.info_circle_fill,
          'label': "About Us",
          'color': const Color(0xFF10B981),
          'page': null // No page navigation for this item
        },
        {
          'icon': CupertinoIcons.doc_text_fill,
          'label': "Terms",
          'color': const Color(0xFF6366F1),
          'page': null // No page navigation for this item
        },
        {
          'icon': CupertinoIcons.question_circle_fill,
          'label': "Help",
          'color': const Color(0xFFEC4899),
          'page': null // No page navigation for this item
        },
      ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Column(
        children: [
          // Enhanced Top Profile Section
          Container(
            height: size.height * 0.45,
            child: Stack(
              children: [
                // Modern Gradient Wave Background
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(size.width, size.height * 0.45),
                      painter: WavePainter(
                        // color1: const Color(0xFF667EEA),
                        // color2: const Color(0xFF764BA2),
                        color1: Appcolors.kprimarycolor,
                        color2: Appcolors.kprimarycolor,
                        animationValue: _waveController.value * 2 * math.pi,
                      ),
                    );
                  },
                ),

                // Floating Decorative Elements
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(size.width, size.height * 0.45),
                      painter: CircleDecorPainter(
                        animationValue: _waveController.value * 2 * math.pi,
                      ),
                    );
                  },
                ),

                // Profile Content
                SafeArea(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        size.width * 0.06,
                        size.height * 0.02,
                        size.width * 0.06,
                        size.height * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with Profile and Edit
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, -0.5),
                              end: Offset.zero,
                            ).animate(_slideAnimation),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Enhanced Profile Image
                                Hero(
                                  tag: 'profile_image',
                                  child: Container(
                                    width: size.width * 0.28,
                                    height: size.width * 0.28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, -2),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        'https://anakoskaphotography.com/wp-content/uploads/2018/09/outdoor-children-photo-of-a-girl.jpg',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            child: Icon(
                                              Icons.person,
                                              size: size.width * 0.12,
                                              color: Colors.grey[600],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                // Modern Edit Button
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        // Navigate to edit profile
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ScreenEditProfile(),
                                          ),
                                        );
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(14.0),
                                        child: Icon(
                                          Icons.edit_rounded,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: size.height * 0.04),

                          // Enhanced Name and Email Section
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-0.3, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: _slideAnimation,
                              curve: const Interval(0.3, 1.0,
                                  curve: Curves.easeOutCubic),
                            )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name with better typography
                                Text(
                                  'Ribinraj',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 2),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // Enhanced Email Container
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: Colors.white.withOpacity(0.9),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'ribinrajop@gmail.com',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withOpacity(0.95),
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: size.height * 0.02),

          // Enhanced Category Grid Section
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 800 + (index * 100)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: _buildCategoryCard(categories[index], context),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          // Enhanced Logout Button
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.3, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _slideAnimation,
              curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
            )),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.05,
                0,
                size.width * 0.05,
                size.height * 0.04,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFEF4444).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout_rounded, size: 20),
                    label: const Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.018,
                        horizontal: size.width * 0.08,
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      Map<String, dynamic> category, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: category['color'].withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
              const BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                _handleCategoryTap(category, context);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: category['color'].withOpacity(0.1),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        category['icon'],
                        size: 28,
                        color: category['color'],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(
                        category['label'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey[800],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Handle category tap navigation
  void _handleCategoryTap(Map<String, dynamic> category, BuildContext context) {
    if (category['page'] != null) {
      // Navigate to the specified page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => category['page'],
        ),
      );
    } else {
      // Handle other actions or show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${category['label']} feature coming soon!'),
          backgroundColor: category['color'],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  // Logout Function
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedLanguage');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ScreenLoginpage()),
      (route) => false,
    );
  }
}
