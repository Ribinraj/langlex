import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/screens/homepage/widgets/category_container.dart';

import 'package:langlex/presentation/screens/homepage/widgets/custom_appbar.dart';
import 'package:langlex/presentation/screens/individual_contentpage/individualpage.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_profile_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Custom painter for beautiful background patterns
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw floating circles
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      30,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.1),
      20,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.7),
      25,
      paint,
    );

    // Draw curved lines
    final path = Path();
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.4,
      size.width,
      size.height * 0.8,
    );

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for grid item decoration
class GridItemPainter extends CustomPainter {
  final Color color;

  GridItemPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw success pattern
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.8, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ignore: must_be_immutable
class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({super.key});

  @override
  State<ScreenHomePage> createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage>
    with TickerProviderStateMixin {
  List caroselimages = [
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
    'assets/images/carosel4.jpg'
  ];

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      key: scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Appcolors.kprimarycolor,
                Color.fromARGB(255, 169, 223, 208),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        surfaceTintColor: const Color.fromARGB(255, 66, 178, 146),
        elevation: 0,
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const CustomRoundImage(
                      circleContainerSize: 45,
                      imageUrl:
                          'https://anakoskaphotography.com/wp-content/uploads/2018/09/outdoor-children-photo-of-a-girl.jpg',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          const DropdownExample(),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.2),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Appcolors.kwhiteColor,
                size: 25,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
          ResponsiveSizedBox.height10,
        ],
      ),
      body: ListView(
        children: [
          // Enhanced header section
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 105, 184, 161),
                    Color.fromARGB(255, 174, 227, 212),
                    Color.fromARGB(255, 200, 243, 239),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: CustomPaint(
                painter: BackgroundPainter(),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      // Background with overlay
                      Container(
                        height: ResponsiveUtils.hp(28),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/back-school-background.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.1),
                              BlendMode.overlay,
                            ),
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        height: ResponsiveUtils.hp(28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                      // Text content
                      Positioned(
                        top: ResponsiveUtils.hp(6),
                        left: ResponsiveUtils.wp(5),
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Play, learn, and\ngrow together!",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.fredoka(
                                  fontSize: ResponsiveUtils.wp(6),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "🌟 Fun Learning Experience",
                                  style: GoogleFonts.fredoka(
                                    fontSize: ResponsiveUtils.wp(3.5),
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF4CAF50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Floating elements
                      Positioned(
                        top: ResponsiveUtils.hp(3),
                        right: ResponsiveUtils.wp(8),
                        child: AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _pulseController.value * 0.1,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 30,
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

          const SizedBox(height: 20),

          // Content section with better spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section title
                SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    "Learning Content",
                    style: GoogleFonts.fredoka(
                      fontSize: ResponsiveUtils.wp(5.5),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E3440),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tap to explore interactive learning modules",
                  style: GoogleFonts.inter(
                    fontSize: ResponsiveUtils.wp(3.5),
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ResponsiveSizedBox.height20,
                // Fixed widget tree structure
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Remove the unnecessary Row wrapper
                      SlideTransition(
                        position: _slideAnimation,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          // Remove Positioned.fill and use proper container
                          child: GridView.count(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  crossAxisCount: 2,
  crossAxisSpacing: 15,
  mainAxisSpacing: 20,
  children: [
    CategoryContainer(
      title: "Knowledge",
      imagePath: 'assets/images/70967.jpg',
      onTap: () {
        CustomNavigation.push(context, ScreenIndividualPage());
      },
    ),
    CategoryContainer(
      title: "Stories",
      imagePath: 'assets/images/25590.jpg',
      onTap: () {
        CustomNavigation.push(context, ScreenIndividualPage());
      },
    ),
    CategoryContainer(
      title: "Alphabets",
      imagePath: 'assets/images/carosel2.jpg',
      onTap: () {
        CustomNavigation.push(context, ScreenIndividualPage());
      },
    ),
    CategoryContainer(
      title: "Quizzes",
      imagePath: 'assets/images/2149001124.jpg',
      onTap: () {
        CustomNavigation.push(context, ScreenIndividualPage());
      },
    ),
  ],
),
                          // child: Column(
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             CustomNavigation.push(
                          //                 context, ScreenIndividualPage());
                          //           },
                          //           borderRadius: BorderRadius.circular(24),
                          //           child: AnimatedContainer(
                          //             duration:
                          //                 const Duration(milliseconds: 400),
                          //             curve: Curves.easeInOut,
                          //             decoration: BoxDecoration(
                          //               gradient: LinearGradient(
                          //                 begin: Alignment.topLeft,
                          //                 end: Alignment.bottomRight,
                          //                 colors: [
                          //                   const Color.fromARGB(
                          //                       255, 93, 194, 165),
                          //                   const Color.fromARGB(
                          //                           255, 132, 193, 176)
                          //                       .withOpacity(0.8),
                          //                   Appcolors.kgreenlightColor,
                          //                   const Color.fromARGB(
                          //                           255, 222, 234, 230)
                          //                       .withOpacity(0.9),
                          //                 ],
                          //                 stops: const [0.0, 0.3, 0.7, 1.0],
                          //               ),
                          //               borderRadius: BorderRadius.circular(24),
                          //               border: Border.all(
                          //                 color: Appcolors.kprimarycolor
                          //                     .withOpacity(0.6),
                          //                 width: 2,
                          //               ),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color: Appcolors.kprimarycolor
                          //                       .withOpacity(0.4),
                          //                   blurRadius: 20,
                          //                   spreadRadius: 2,
                          //                   offset: const Offset(0, 8),
                          //                 ),
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.white.withOpacity(0.3),
                          //                   blurRadius: 10,
                          //                   spreadRadius: -3,
                          //                   offset: const Offset(0, -3),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   horizontal: 15, vertical: 10),
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     decoration: BoxDecoration(
                          //                       shape: BoxShape.circle,
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.8),
                          //                         width: 2,
                          //                       ),
                          //                       boxShadow: [
                          //                         BoxShadow(
                          //                           color: Colors.black
                          //                               .withOpacity(0.2),
                          //                           blurRadius: 8,
                          //                           offset: const Offset(0, 4),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     child: ClipOval(
                          //                       // This clips the image to circle shape
                          //                       child: Image.asset(
                          //                         'assets/images/70967.jpg',
                          //                         fit: BoxFit.cover,
                          //                         width: ResponsiveUtils.wp(30),
                          //                         height:
                          //                             ResponsiveUtils.wp(30),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   ResponsiveSizedBox.height10,
                          //                   Container(
                          //                     padding:
                          //                         const EdgeInsets.symmetric(
                          //                             horizontal: 12,
                          //                             vertical: 4),
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.white
                          //                           .withOpacity(0.2),
                          //                       borderRadius:
                          //                           BorderRadius.circular(12),
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.3),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: const Text(
                          //                       "Knowledge",
                          //                       style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.w800,
                          //                         letterSpacing: 1.0,
                          //                         shadows: [
                          //                           Shadow(
                          //                             color: Colors.black26,
                          //                             offset: Offset(0, 2),
                          //                             blurRadius: 4,
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     // child: const LocaleText(
                          //                     //   "Knowledge",
                          //                     //   style: TextStyle(
                          //                     //     color: Colors.white,
                          //                     //     fontSize: 18,
                          //                     //     fontWeight: FontWeight.w800,
                          //                     //     letterSpacing: 1.0,
                          //                     //     shadows: [
                          //                     //       Shadow(
                          //                     //         color: Colors.black26,
                          //                     //         offset: Offset(0, 2),
                          //                     //         blurRadius: 4,
                          //                     //       ),
                          //                     //     ],
                          //                     //   ),
                          //                     // ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             CustomNavigation.push(
                          //                 context, ScreenIndividualPage());
                          //           },
                          //           borderRadius: BorderRadius.circular(24),
                          //           child: AnimatedContainer(
                          //             duration:
                          //                 const Duration(milliseconds: 400),
                          //             curve: Curves.easeInOut,
                          //             decoration: BoxDecoration(
                          //               gradient: LinearGradient(
                          //                 begin: Alignment.topLeft,
                          //                 end: Alignment.bottomRight,
                          //                 colors: [
                          //                   const Color.fromARGB(
                          //                       255, 93, 194, 165),
                          //                   const Color.fromARGB(
                          //                           255, 132, 193, 176)
                          //                       .withOpacity(0.8),
                          //                   Appcolors.kgreenlightColor,
                          //                   const Color.fromARGB(
                          //                           255, 222, 234, 230)
                          //                       .withOpacity(0.9),
                          //                 ],
                          //                 stops: const [0.0, 0.3, 0.7, 1.0],
                          //               ),
                          //               borderRadius: BorderRadius.circular(24),
                          //               border: Border.all(
                          //                 color: Appcolors.kprimarycolor
                          //                     .withOpacity(0.6),
                          //                 width: 2,
                          //               ),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color: Appcolors.kprimarycolor
                          //                       .withOpacity(0.4),
                          //                   blurRadius: 20,
                          //                   spreadRadius: 2,
                          //                   offset: const Offset(0, 8),
                          //                 ),
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.white.withOpacity(0.3),
                          //                   blurRadius: 10,
                          //                   spreadRadius: -3,
                          //                   offset: const Offset(0, -3),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   horizontal: 15, vertical: 10),
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     decoration: BoxDecoration(
                          //                       shape: BoxShape.circle,
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.8),
                          //                         width: 2,
                          //                       ),
                          //                       boxShadow: [
                          //                         BoxShadow(
                          //                           color: Colors.black
                          //                               .withOpacity(0.2),
                          //                           blurRadius: 8,
                          //                           offset: const Offset(0, 4),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     child: ClipOval(
                          //                       // This clips the image to circle shape
                          //                       child: Image.asset(
                          //                         'assets/images/25590.jpg',
                          //                         fit: BoxFit.cover,
                          //                         width: ResponsiveUtils.wp(30),
                          //                         height:
                          //                             ResponsiveUtils.wp(30),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   ResponsiveSizedBox.height10,
                          //                   Container(
                          //                     padding:
                          //                         const EdgeInsets.symmetric(
                          //                             horizontal: 12,
                          //                             vertical: 4),
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.white
                          //                           .withOpacity(0.2),
                          //                       borderRadius:
                          //                           BorderRadius.circular(12),
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.3),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: const Text(
                          //                       "Stories",
                          //                       style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.w800,
                          //                         letterSpacing: 1.0,
                          //                         shadows: [
                          //                           Shadow(
                          //                             color: Colors.black26,
                          //                             offset: Offset(0, 2),
                          //                             blurRadius: 4,
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     // child: const LocaleText(
                          //                     //   "Knowledge",
                          //                     //   style: TextStyle(
                          //                     //     color: Colors.white,
                          //                     //     fontSize: 18,
                          //                     //     fontWeight: FontWeight.w800,
                          //                     //     letterSpacing: 1.0,
                          //                     //     shadows: [
                          //                     //       Shadow(
                          //                     //         color: Colors.black26,
                          //                     //         offset: Offset(0, 2),
                          //                     //         blurRadius: 4,
                          //                     //       ),
                          //                     //     ],
                          //                     //   ),
                          //                     // ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     ResponsiveSizedBox.height20,
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             CustomNavigation.push(
                          //                 context, ScreenIndividualPage());
                          //           },
                          //           borderRadius: BorderRadius.circular(24),
                          //           child: AnimatedContainer(
                          //             duration:
                          //                 const Duration(milliseconds: 400),
                          //             curve: Curves.easeInOut,
                          //             decoration: BoxDecoration(
                          //               gradient: LinearGradient(
                          //                 begin: Alignment.topLeft,
                          //                 end: Alignment.bottomRight,
                          //                 colors: [
                          //                   const Color.fromARGB(
                          //                       255, 93, 194, 165),
                          //                   const Color.fromARGB(
                          //                           255, 132, 193, 176)
                          //                       .withOpacity(0.8),
                          //                   Appcolors.kgreenlightColor,
                          //                   const Color.fromARGB(
                          //                           255, 222, 234, 230)
                          //                       .withOpacity(0.9),
                          //                 ],
                          //                 stops: const [0.0, 0.3, 0.7, 1.0],
                          //               ),
                          //               borderRadius: BorderRadius.circular(24),
                          //               border: Border.all(
                          //                 color: Appcolors.kprimarycolor
                          //                     .withOpacity(0.6),
                          //                 width: 2,
                          //               ),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color: Appcolors.kprimarycolor
                          //                       .withOpacity(0.4),
                          //                   blurRadius: 20,
                          //                   spreadRadius: 2,
                          //                   offset: const Offset(0, 8),
                          //                 ),
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.white.withOpacity(0.3),
                          //                   blurRadius: 10,
                          //                   spreadRadius: -3,
                          //                   offset: const Offset(0, -3),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   horizontal: 15, vertical: 10),
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     decoration: BoxDecoration(
                          //                       shape: BoxShape.circle,
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.8),
                          //                         width: 2,
                          //                       ),
                          //                       boxShadow: [
                          //                         BoxShadow(
                          //                           color: Colors.black
                          //                               .withOpacity(0.2),
                          //                           blurRadius: 8,
                          //                           offset: const Offset(0, 4),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     child: ClipOval(
                          //                       // This clips the image to circle shape
                          //                       child: Image.asset(
                          //                         'assets/images/carosel2.jpg',
                          //                         fit: BoxFit.cover,
                          //                         width: ResponsiveUtils.wp(30),
                          //                         height:
                          //                             ResponsiveUtils.wp(30),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   ResponsiveSizedBox.height10,
                          //                   Container(
                          //                     padding:
                          //                         const EdgeInsets.symmetric(
                          //                             horizontal: 12,
                          //                             vertical: 4),
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.white
                          //                           .withOpacity(0.2),
                          //                       borderRadius:
                          //                           BorderRadius.circular(12),
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.3),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: const Text(
                          //                       "Alphabets",
                          //                       style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.w800,
                          //                         letterSpacing: 1.0,
                          //                         shadows: [
                          //                           Shadow(
                          //                             color: Colors.black26,
                          //                             offset: Offset(0, 2),
                          //                             blurRadius: 4,
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     // child: const LocaleText(
                          //                     //   "Knowledge",
                          //                     //   style: TextStyle(
                          //                     //     color: Colors.white,
                          //                     //     fontSize: 18,
                          //                     //     fontWeight: FontWeight.w800,
                          //                     //     letterSpacing: 1.0,
                          //                     //     shadows: [
                          //                     //       Shadow(
                          //                     //         color: Colors.black26,
                          //                     //         offset: Offset(0, 2),
                          //                     //         blurRadius: 4,
                          //                     //       ),
                          //                     //     ],
                          //                     //   ),
                          //                     // ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             CustomNavigation.push(
                          //                 context, ScreenIndividualPage());
                          //           },
                          //           borderRadius: BorderRadius.circular(24),
                          //           child: AnimatedContainer(
                          //             duration:
                          //                 const Duration(milliseconds: 400),
                          //             curve: Curves.easeInOut,
                          //             decoration: BoxDecoration(
                          //               gradient: LinearGradient(
                          //                 begin: Alignment.topLeft,
                          //                 end: Alignment.bottomRight,
                          //                 colors: [
                          //                   const Color.fromARGB(
                          //                       255, 93, 194, 165),
                          //                   const Color.fromARGB(
                          //                           255, 132, 193, 176)
                          //                       .withOpacity(0.8),
                          //                   Appcolors.kgreenlightColor,
                          //                   const Color.fromARGB(
                          //                           255, 222, 234, 230)
                          //                       .withOpacity(0.9),
                          //                 ],
                          //                 stops: const [0.0, 0.3, 0.7, 1.0],
                          //               ),
                          //               borderRadius: BorderRadius.circular(24),
                          //               border: Border.all(
                          //                 color: Appcolors.kprimarycolor
                          //                     .withOpacity(0.6),
                          //                 width: 2,
                          //               ),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color: Appcolors.kprimarycolor
                          //                       .withOpacity(0.4),
                          //                   blurRadius: 20,
                          //                   spreadRadius: 2,
                          //                   offset: const Offset(0, 8),
                          //                 ),
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.white.withOpacity(0.3),
                          //                   blurRadius: 10,
                          //                   spreadRadius: -3,
                          //                   offset: const Offset(0, -3),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   horizontal: 15, vertical: 10),
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     decoration: BoxDecoration(
                          //                       shape: BoxShape.circle,
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.8),
                          //                         width: 2,
                          //                       ),
                          //                       boxShadow: [
                          //                         BoxShadow(
                          //                           color: Colors.black
                          //                               .withOpacity(0.2),
                          //                           blurRadius: 8,
                          //                           offset: const Offset(0, 4),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     child: ClipOval(
                          //                       // This clips the image to circle shape
                          //                       child: Image.asset(
                          //                         'assets/images/2149001124.jpg',
                          //                         fit: BoxFit.cover,
                          //                         width: ResponsiveUtils.wp(30),
                          //                         height:
                          //                             ResponsiveUtils.wp(30),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   ResponsiveSizedBox.height10,
                          //                   Container(
                          //                     padding:
                          //                         const EdgeInsets.symmetric(
                          //                             horizontal: 12,
                          //                             vertical: 4),
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.white
                          //                           .withOpacity(0.2),
                          //                       borderRadius:
                          //                           BorderRadius.circular(12),
                          //                       border: Border.all(
                          //                         color: Colors.white
                          //                             .withOpacity(0.3),
                          //                         width: 1,
                          //                       ),
                          //                     ),
                          //                     child: const Text(
                          //                       "Quizzes",
                          //                       style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.w800,
                          //                         letterSpacing: 1.0,
                          //                         shadows: [
                          //                           Shadow(
                          //                             color: Colors.black26,
                          //                             offset: Offset(0, 2),
                          //                             blurRadius: 4,
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     // child: const LocaleText(
                          //                     //   "Knowledge",
                          //                     //   style: TextStyle(
                          //                     //     color: Colors.white,
                          //                     //     fontSize: 18,
                          //                     //     fontWeight: FontWeight.w800,
                          //                     //     letterSpacing: 1.0,
                          //                     //     shadows: [
                          //                     //       Shadow(
                          //                     //         color: Colors.black26,
                          //                     //         offset: Offset(0, 2),
                          //                     //         blurRadius: 4,
                          //                     //       ),
                          //                     //     ],
                          //                     //   ),
                          //                     // ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ),
                      )
                    ],
                  ),
                )

// Alternative approach using CircleAvatar for even simpler circular images:
/*
CircleAvatar(
  radius: ResponsiveUtils.wp(8), // Half of the desired diameter
  backgroundColor: Colors.white.withOpacity(0.8),
  child: CircleAvatar(
    radius: ResponsiveUtils.wp(8) - 3, // Subtract border width
    backgroundImage: AssetImage('assets/images/70967.jpg'),
    backgroundColor: Colors.grey[300], // Fallback color
  ),
)
*/
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildImageWithFallback({
    required String imageUrl,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Center(
          child: LoadingAnimationWidget.bouncingBall(
              color: Appcolors.kwhiteColor, size: ResponsiveUtils.wp(10))),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: ResponsiveUtils.wp(10),
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              'Image not available',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: ResponsiveUtils.wp(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
