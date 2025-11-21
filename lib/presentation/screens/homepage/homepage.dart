import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/fetch_primarycategory_bloc.dart/fetch_primarycategory_bloc.dart';
import 'package:langlex/presentation/screens/homepage/widgets/category_container.dart';

import 'package:langlex/presentation/screens/homepage/widgets/custom_appbar.dart';
import 'package:langlex/presentation/screens/homepage/widgets/custom_painter.dart';
import 'package:langlex/presentation/screens/individual_contentpage/individualpage.dart';
import 'package:langlex/presentation/screens/primary_categories/primary_categories.dart';
import 'package:langlex/presentation/screens/screen_letterspage/screen_letters.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_profile_image.dart';
import 'package:langlex/presentation/widgets/custom_sharedpreferences.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({super.key});

  @override
  State<ScreenHomePage> createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late int languageId;
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
    fetchtlanguageId();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  fetchtlanguageId() async {
    languageId = await getLanguageId();
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
                                "Play, learn, and\n         grow together!",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.fredoka(
                                  fontSize: ResponsiveUtils.wp(6),
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 225, 225, 11),
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
                            childAspectRatio: .85,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20,
                            children: [
                              CategoryContainer(
                                title: "Knowledge",
                                imagePath: 'assets/images/70967.jpg',
                                onTap: () {
                                 
                                  CustomNavigation.push(
                                      context,
                                      PrimaryCategoriesPage(
                                        languageId: languageId,
                                     
                                          heading: 'Knowledge'));
                                },
                              ),
                              CategoryContainer(
                                title: "Stories",
                                imagePath: 'assets/images/25590.jpg',
                                onTap: () {
                                      //   context.read<FetchPrimarycategoryBloc>().add(
                                      // FetchPrimaryCategoryInitialEvent(
                                      //     category: 'Stories',
                                      //     languageId: languageId));
                                  CustomNavigation.push(
                                      context,
                                      PrimaryCategoriesPage(
                                            languageId: languageId,
                              
                                          heading: "Stories"));
                                },
                              ),
                              CategoryContainer(
                                title: "Alphabets",
                                imagePath: 'assets/images/carosel2.jpg',
                                onTap: () {
                    CustomNavigation.push(context,LettersGalleryScreen());
                                },
                              ),
                              CategoryContainer(
                                title: "Quizzes",
                                imagePath: 'assets/images/2149001124.jpg',
                                onTap: () {
                                      //     context.read<FetchPrimarycategoryBloc>().add(
                                      // FetchPrimaryCategoryInitialEvent(
                                      //     category: 'Quizzes',
                                      //     languageId: languageId));
                                  CustomNavigation.push(
                                      context,
                                      PrimaryCategoriesPage(
                                            languageId: languageId,
                                     
                                          heading: "Quizzes"));
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
