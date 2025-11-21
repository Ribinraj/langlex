
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/profile_model.dart';
import 'package:langlex/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';

import 'package:langlex/presentation/screens/editprofile_page/editprofile.dart';
import 'package:langlex/presentation/screens/loginpage/loginpage.dart';
import 'package:langlex/presentation/screens/profilepage/widgets/paintings.dart';
import 'package:langlex/presentation/screens/quiz_screen/quiz_screen.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

import 'package:shared_preferences/shared_preferences.dart';



import 'dart:math' as math;




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

    // Trigger profile fetch
    context.read<FetchProfileBloc>().add(FetchProfileButtonClickEvent());

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

  List<Map<String, dynamic>> get categories => [
        {
          'icon': CupertinoIcons.book_fill,
          'label': "My Courses",
          'color': const Color(0xFF3B82F6),
          'page': const ScreenQuizPage()
        },
        {
          'icon': CupertinoIcons.cube_box_fill,
          'label': "Packages",
          'color': const Color(0xFF8B5CF6),
          'page': const ScreenQuizPage()
        },
        {
          'icon': CupertinoIcons.shield_lefthalf_fill,
          'label': "Privacy",
          'color': const Color(0xFFF59E0B),
          'page': null
        },
        {
          'icon': CupertinoIcons.info_circle_fill,
          'label': "About Us",
          'color': const Color(0xFF10B981),
          'page': null
        },
        {
          'icon': CupertinoIcons.doc_text_fill,
          'label': "Terms",
          'color': const Color(0xFF6366F1),
          'page': null
        },
        {
          'icon': CupertinoIcons.question_circle_fill,
          'label': "Help",
          'color': const Color(0xFFEC4899),
          'page': null
        },
      ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: BlocConsumer<FetchProfileBloc, FetchProfileState>(
        listener: (context, state) {
          if (state is FetchProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FetchProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Appcolors.kprimarycolor,
              ),
            );
          }

          if (state is FetchProfileErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Failed to load profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(state.message),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FetchProfileBloc>().add(
                            FetchProfileButtonClickEvent(),
                          );
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final profile = state is FetchProfileSuccessState ? state.profile : null;

          return Column(
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
                                          child: profile?.userPicture != null && 
                                                 profile!.userPicture!.isNotEmpty
                                              ? Image.network(
                                                   "${Endpoints.baseprofileimageurl}${profile.userPicture!}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return _buildDefaultAvatar(size);
                                                  },
                                                )
                                              : _buildDefaultAvatar(size),
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
  if (profile != null) {
CustomNavigation.pushWithTransition(context, ScreenEditProfile(        profile: ProfileModel(
            userName: profile.userName,
            mobileNumber: profile.mobileNumber,
            emailAddress: profile.emailAddress,
            userPicture: profile.userPicture,
          ),));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile not loaded yet'),
      ),
    );
  }
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

                              ResponsiveSizedBox.height5,

                              // Enhanced Name and Contact Information
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
                                    // Name
                                    Text(
                                      profile?.userName ?? 'User',
                                      style: TextStyle(
                                        fontSize:ResponsiveUtils.wp(5),
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

                                    ResponsiveSizedBox.height5,
   
                                    if (profile?.mobileNumber != null && 
                                        profile!.mobileNumber!.isNotEmpty)
                                      _buildInfoContainer(
                                        icon: Icons.phone_outlined,
                                        text: profile.mobileNumber!,
                                      ),
                                        ResponsiveSizedBox.height10,
                                    // Email Container
                                    if (profile?.emailAddress != null && 
                                        profile!.emailAddress!.isNotEmpty)
                                      _buildInfoContainer(
                                        icon: Icons.email_outlined,
                                        text: profile.emailAddress!,
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
          );
        },
      ),
    );
  }

  Widget _buildDefaultAvatar(Size size) {
    return Container(
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        size: size.width * 0.12,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildInfoContainer({required IconData icon, required String text}) {
    return Container(
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
            icon,
            color: Colors.white.withOpacity(0.9),
            size: 18,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.95),
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
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

  void _handleCategoryTap(Map<String, dynamic> category, BuildContext context) {
    if (category['page'] != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => category['page'],
        ),
      );
    } else {
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

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedLanguage');
    navigateToMainPage(context, 0);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ScreenLoginpage()),
      (route) => false,
    );
  }}