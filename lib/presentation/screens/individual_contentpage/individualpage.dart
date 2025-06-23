import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/Fetch_data_from_database/fetchdata_from_database_bloc.dart';

import 'package:langlex/presentation/widgets/audio_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// class ScreenIndividualPage extends StatefulWidget {
//   const ScreenIndividualPage({super.key});

//   @override
//   State<ScreenIndividualPage> createState() => _ScreenIndividualPageState();
// }

// class _ScreenIndividualPageState extends State<ScreenIndividualPage>
//     with TickerProviderStateMixin {
//   final AudioService _audioService = AudioService();
//   late AnimationController _imageAnimationController;
//   late AnimationController _controlsAnimationController;
//   late Animation<double> _imageScaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   int currentIndex = 0;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controllers
//     _imageAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _controlsAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     // Setup animations
//     _imageScaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _imageAnimationController,
//       curve: Curves.elasticOut,
//     ));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controlsAnimationController,
//       curve: Curves.easeInOut,
//     ));

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controlsAnimationController,
//       curve: Curves.easeOutBack,
//     ));

//     // Start animations
//     _imageAnimationController.forward();
//     _controlsAnimationController.forward();

//     context
//         .read<FetchdataFromDatabaseBloc>()
//         .add(FetchDataFromDatabaseInitialEvent());
//   }

//   @override
//   void dispose() {
//     _imageAnimationController.dispose();
//     _controlsAnimationController.dispose();
//     super.dispose();
//   }

//   void _animateItemChange() {
//     _imageAnimationController.reset();
//     _imageAnimationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<FetchdataFromDatabaseBloc, FetchdataFromDatabaseState>(
//         builder: (context, state) {
//           if (state is FetchDataFromDatabaseLoadingState) {
//             return Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 71, 158, 133), // kgreenColor
//                     Color.fromARGB(255, 107, 197, 172), // kgreenlightColor
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     LoadingAnimationWidget.fourRotatingDots(
//                       color: Colors.white,
//                       size: 50,
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Loading...',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else if (state is FetchDataFromDatabaseSuccessState) {
//             final dataItems = state.dataItems;
//             if (dataItems.isEmpty) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 71, 158, 133),
//                       Color.fromARGB(255, 107, 197, 172),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.inbox_outlined,
//                         size: 80,
//                         color: Colors.white.withOpacity(0.7),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         'No items to display',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             final item = dataItems[currentIndex];

//             return Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 71, 158, 133), // kgreenColor
//                     Color.fromARGB(255, 107, 197, 172), // kgreenlightColor
//                     Color.fromARGB(255, 138, 124, 108), // korangeColor
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   stops: [0.0, 0.7, 1.0],
//                 ),
//               ),
//               child: SafeArea(
//                 child: Padding(
//                   padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                   child: Column(
//                     children: [
//                       // Enhanced Header Section
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: ResponsiveUtils.wp(2),
//                           vertical: ResponsiveUtils.hp(1),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // Back Button with Glassmorphism
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.white.withOpacity(0.3),
//                                   width: 1,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 10,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: IconButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(
//                                   CupertinoIcons.arrow_left,
//                                   color: Colors.white,
//                                   size: ResponsiveUtils.wp(6),
//                                 ),
//                               ),
//                             ),

//                             // Beautiful Title
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: ResponsiveUtils.wp(6),
//                                 vertical: ResponsiveUtils.hp(1),
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: Colors.white.withOpacity(0.3),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Text(
//                                 'Animals',
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: ResponsiveUtils.hp(2.5),
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ),

//                             // Enhanced Progress Indicator
//                             Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(50),
//                                 border: Border.all(
//                                   color: Colors.white.withOpacity(0.3),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: CircularPercentIndicator(
//                                 radius: ResponsiveUtils.wp(6),
//                                 center: Text(
//                                   "${((currentIndex + 1) / dataItems.length * 100).toInt()}%",
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 11,
//                                   ),
//                                 ),
//                                 lineWidth: 4.0,
//                                 animation: true,
//                                 animationDuration: 800,
//                                 percent: (currentIndex + 1) / dataItems.length,
//                                 circularStrokeCap: CircularStrokeCap.round,
//                                 progressColor: Colors.white,
//                                 backgroundColor: Colors.white.withOpacity(0.3),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: ResponsiveUtils.hp(3)),

//                       // Enhanced Image Card with Animation
//                       Expanded(
//                         flex: 3,
//                         child: AnimatedBuilder(
//                           animation: _imageScaleAnimation,
//                           builder: (context, child) {
//                             return Transform.scale(
//                               scale: _imageScaleAnimation.value,
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: ResponsiveUtils.wp(2),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       blurRadius: 20,
//                                       offset: const Offset(0, 10),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(25),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Colors.white.withOpacity(0.1),
//                                           Colors.transparent,
//                                         ],
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                       ),
//                                     ),
//                                     padding: const EdgeInsets.all(8),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(17),
//                                       child: Image.file(
//                                         File(
//                                             '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}'),
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),

//                       SizedBox(height: ResponsiveUtils.hp(3)),

//                       // Enhanced Animal Name
//                       SlideTransition(
//                         position: _slideAnimation,
//                         child: FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: Container(
//                             width: double.infinity,
//                             padding: EdgeInsets.symmetric(
//                               horizontal: ResponsiveUtils.wp(8),
//                               vertical: ResponsiveUtils.hp(1),
//                             ),
//                             decoration: BoxDecoration(
//                               color: Appcolors.korangeColor.withOpacity(0.7),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: Colors.white.withOpacity(0.3),
//                                 width: 1,
//                               ),
//                             ),
//                             child: Text(
//                               'Lion',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: ResponsiveUtils.hp(2.5),
//                                 letterSpacing: 1,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: ResponsiveUtils.hp(4)),

//                       // Enhanced Progress Bar
//                       SlideTransition(
//                         position: _slideAnimation,
//                         child: FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: Container(
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: ResponsiveUtils.wp(4)),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       '${currentIndex + 1}',
//                                       style: GoogleFonts.poppins(
//                                         color: Colors.white.withOpacity(0.8),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${dataItems.length}',
//                                       style: GoogleFonts.poppins(
//                                         color: Colors.white.withOpacity(0.8),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 8),
//                                 TweenAnimationBuilder(
//                                   duration: const Duration(milliseconds: 600),
//                                   tween: Tween<double>(
//                                     begin: 0,
//                                     end: (currentIndex + 1) / dataItems.length,
//                                   ),
//                                   builder: (context, double value, child) {
//                                     return Container(
//                                       height: 6,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(3),
//                                         color: Colors.white.withOpacity(0.2),
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(3),
//                                         child: LinearProgressIndicator(
//                                           value: value,
//                                           backgroundColor: Colors.transparent,
//                                           valueColor:
//                                               const AlwaysStoppedAnimation<
//                                                   Color>(Colors.white),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: ResponsiveUtils.hp(4)),

//                       // Enhanced Control Buttons
//                       SlideTransition(
//                         position: _slideAnimation,
//                         child: FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: ResponsiveUtils.wp(4),
//                               vertical: ResponsiveUtils.hp(2),
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(
//                                 color: Colors.white.withOpacity(0.2),
//                                 width: 1,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 // Previous Button
//                                 _buildControlButton(
//                                   icon: CupertinoIcons.backward_fill,
//                                   onPressed: currentIndex > 0
//                                       ? () {
//                                           setState(() {
//                                             currentIndex--;
//                                           });
//                                           _audioService.stopAudio();
//                                           _animateItemChange();
//                                         }
//                                       : null,
//                                   isEnabled: currentIndex > 0,
//                                 ),

//                                 // Play Button (Larger)
//                                 _buildControlButton(
//                                   icon: isPlaying
//                                       ? CupertinoIcons.pause_circle_fill
//                                       : CupertinoIcons.play_circle_fill,
//                                   onPressed: () {
//                                     if (isPlaying) {
//                                       _audioService.pauseAudio();
//                                       setState(() {
//                                         isPlaying = false;
//                                       });
//                                     } else {
//                                       _audioService.playAudioFromFile(
//                                         '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.mp3}',
//                                       );
//                                       setState(() {
//                                         isPlaying = true;
//                                       });
//                                     }
//                                   },
//                                   size: 70,
//                                   isEnabled: true,
//                                 ),

//                                 // Stop Button
//                                 _buildControlButton(
//                                   icon: CupertinoIcons.stop_circle_fill,
//                                   onPressed: () {
//                                     _audioService.stopAudio();
//                                     setState(() {
//                                       isPlaying = false;
//                                     });
//                                   },
//                                   isEnabled: true,
//                                 ),

//                                 // Next Button
//                                 _buildControlButton(
//                                   icon: CupertinoIcons.forward_fill,
//                                   onPressed: currentIndex < dataItems.length - 1
//                                       ? () {
//                                           setState(() {
//                                             currentIndex++;
//                                           });
//                                           _audioService.stopAudio();
//                                           _animateItemChange();
//                                         }
//                                       : null,
//                                   isEnabled:
//                                       currentIndex < dataItems.length - 1,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: ResponsiveUtils.hp(2)),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   Widget _buildControlButton({
//     required IconData icon,
//     required VoidCallback? onPressed,
//     required bool isEnabled,
//     double size = 55,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isEnabled
//             ? Colors.white.withOpacity(0.2)
//             : Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(size / 2),
//         border: Border.all(
//           color: Colors.white.withOpacity(isEnabled ? 0.4 : 0.2),
//           width: 1,
//         ),
//         boxShadow: isEnabled
//             ? [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ]
//             : null,
//       ),
//       child: IconButton(
//         onPressed: onPressed,
//         icon: Icon(
//           icon,
//           color: isEnabled ? Colors.white : Colors.white.withOpacity(0.5),
//           size: size == 70 ? 50 : 30,
//         ),
//         padding: const EdgeInsets.all(8),
//       ),
//     );
//   }
// }
class ScreenIndividualPage extends StatefulWidget {
  const ScreenIndividualPage({super.key});

  @override
  State<ScreenIndividualPage> createState() => _ScreenIndividualPageState();
}

class _ScreenIndividualPageState extends State<ScreenIndividualPage>
    with TickerProviderStateMixin {
  final AudioService _audioService = AudioService();
  late AnimationController _imageAnimationController;
  late AnimationController _controlsAnimationController;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int currentIndex = 0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _controlsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Setup animations
    _imageScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageAnimationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controlsAnimationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controlsAnimationController,
      curve: Curves.easeOutBack,
    ));

    // Start animations
    _imageAnimationController.forward();
    _controlsAnimationController.forward();

    context
        .read<FetchdataFromDatabaseBloc>()
        .add(FetchDataFromDatabaseInitialEvent());
  }

  @override
  void dispose() {
    _imageAnimationController.dispose();
    _controlsAnimationController.dispose();
    super.dispose();
  }

  void _animateItemChange() {
    _imageAnimationController.reset();
    _imageAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchdataFromDatabaseBloc, FetchdataFromDatabaseState>(
        builder: (context, state) {
          if (state is FetchDataFromDatabaseLoadingState) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF8FAFC), // Soft white
                    Color(0xFFF1F5F9), // Light gray-blue
                    Color(0xFFE2E8F0), // Subtle gray
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
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.kprimarycolor.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Appcolors.kprimarycolor,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Loading Animals...',
                      style: GoogleFonts.poppins(
                        color: Appcolors.ktextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is FetchDataFromDatabaseSuccessState) {
            final dataItems = state.dataItems;
            if (dataItems.isEmpty) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF8FAFC),
                      Color(0xFFF1F5F9),
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
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolors.kprimarycolor.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.pets_outlined,
                          size: 80,
                          color: Appcolors.kprimarycolor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No Animals Found',
                        style: GoogleFonts.poppins(
                          color: Appcolors.ktextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Check back later for new content',
                        style: GoogleFonts.poppins(
                          color: Appcolors.khinttextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final item = dataItems[currentIndex];

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF8FAFC), // Pure white start
                    Color(0xFFF1F5F9), // Soft blue-gray
                    Color(0xFFE2E8F0), // Light gray end
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                  child: Column(
                    children: [
                      // Enhanced Header Section
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(2),
                          vertical: ResponsiveUtils.hp(1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button with modern design
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Appcolors.kprimarycolor
                                        .withOpacity(0.15),
                                    blurRadius: 15,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(
                                  color:
                                      Appcolors.kprimarycolor.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Appcolors.kprimarycolor,
                                  size: ResponsiveUtils.wp(6),
                                ),
                              ),
                            ),

                            // Beautiful Title with gradient background
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(6),
                                vertical: ResponsiveUtils.hp(1.2),
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Appcolors.kprimarycolor,
                                    Appcolors.kgreenlightColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Appcolors.kprimarycolor
                                        .withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Animals',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: ResponsiveUtils.hp(2.5),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),

                            // Enhanced Progress Indicator
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Appcolors.kprimarycolor
                                        .withOpacity(0.15),
                                    blurRadius: 15,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(
                                  color:
                                      Appcolors.kprimarycolor.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: CircularPercentIndicator(
                                radius: ResponsiveUtils.wp(6),
                                center: Text(
                                  "${((currentIndex + 1) / dataItems.length * 100).toInt()}%",
                                  style: GoogleFonts.poppins(
                                    color: Appcolors.kprimarycolor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                lineWidth: 4.0,
                                animation: true,
                                animationDuration: 800,
                                percent: (currentIndex + 1) / dataItems.length,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Appcolors.kprimarycolor,
                                backgroundColor:
                                    Appcolors.kgreenlightColor.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(3)),

                      Expanded(
                        flex: 3,
                        child: AnimatedBuilder(
                          animation: _imageScaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _imageScaleAnimation.value,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.wp(2),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Appcolors.kprimarycolor
                                          .withOpacity(0.15),
                                      blurRadius: 25,
                                      offset: const Offset(0, 15),
                                      spreadRadius: 2,
                                    ),
                                    BoxShadow(
                                      color: Appcolors.korangeColor
                                          .withOpacity(0.1),
                                      blurRadius: 40,
                                      offset: const Offset(0, 20),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Appcolors.kgreenlightColor
                                        .withOpacity(0.2),
                                    width: 2,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Appcolors.kprimarycolor
                                                .withOpacity(0.03),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Image.file(
                                        File(
                                            '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}'),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(3)),

                      // Enhanced Animal Name with gradient background
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(8),
                              vertical: ResponsiveUtils.hp(1.5),
                            ),
                            decoration: BoxDecoration(
                              color: Appcolors.korangeColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Lion',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveUtils.hp(2.8),
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(4)),

                      // Enhanced Progress Bar with modern styling
                      // SlideTransition(
                      //   position: _slideAnimation,
                      //   child: FadeTransition(
                      //     opacity: _fadeAnimation,
                      //     child: Container(
                      //       margin: EdgeInsets.symmetric(
                      //           horizontal: ResponsiveUtils.wp(4)),
                      //       padding: const EdgeInsets.all(16),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(20),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color:
                      //                 Appcolors.kprimarycolor.withOpacity(0.1),
                      //             blurRadius: 15,
                      //             offset: const Offset(0, 4),
                      //           ),
                      //         ],
                      //         border: Border.all(
                      //           color:
                      //               Appcolors.kgreenlightColor.withOpacity(0.2),
                      //           width: 1,
                      //         ),
                      //       ),
                      //       child: Column(
                      //         children: [
                      //           Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Container(
                      //                 padding: const EdgeInsets.symmetric(
                      //                   horizontal: 12,
                      //                   vertical: 6,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   color: Appcolors.kprimarycolor
                      //                       .withOpacity(0.1),
                      //                   borderRadius: BorderRadius.circular(12),
                      //                 ),
                      //                 child: Text(
                      //                   '${currentIndex + 1}',
                      //                   style: GoogleFonts.poppins(
                      //                     color: Appcolors.kprimarycolor,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w600,
                      //                   ),
                      //                 ),
                      //               ),
                      //               Container(
                      //                 padding: const EdgeInsets.symmetric(
                      //                   horizontal: 12,
                      //                   vertical: 6,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   color: Appcolors.korangeColor
                      //                       .withOpacity(0.1),
                      //                   borderRadius: BorderRadius.circular(12),
                      //                 ),
                      //                 child: Text(
                      //                   '${dataItems.length}',
                      //                   style: GoogleFonts.poppins(
                      //                     color: Appcolors.korangeColor,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w600,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //           const SizedBox(height: 12),
                      //           TweenAnimationBuilder(
                      //             duration: const Duration(milliseconds: 600),
                      //             tween: Tween<double>(
                      //               begin: 0,
                      //               end: (currentIndex + 1) / dataItems.length,
                      //             ),
                      //             builder: (context, double value, child) {
                      //               return Container(
                      //                 height: 8,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(4),
                      //                   color: Appcolors.kgreenlightColor
                      //                       .withOpacity(0.2),
                      //                 ),
                      //                 child: ClipRRect(
                      //                   borderRadius: BorderRadius.circular(4),
                      //                   child: LinearProgressIndicator(
                      //                     value: value,
                      //                     backgroundColor: Colors.transparent,
                      //                     valueColor:
                      //                         const AlwaysStoppedAnimation<
                      //                             Color>(
                      //                       Appcolors.kprimarycolor,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: ResponsiveUtils.hp(1)),

                      // Enhanced Control Buttons with modern design
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(4),
                              vertical: ResponsiveUtils.hp(2.5),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Appcolors.kprimarycolor.withOpacity(0.15),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                  spreadRadius: 2,
                                ),
                              ],
                              border: Border.all(
                                color:
                                    Appcolors.kgreenlightColor.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Previous Button
                                _buildControlButton(
                                  icon: CupertinoIcons.backward_fill,
                                  onPressed: currentIndex > 0
                                      ? () {
                                          setState(() {
                                            currentIndex--;
                                          });
                                          _audioService.stopAudio();
                                          _animateItemChange();
                                        }
                                      : null,
                                  isEnabled: currentIndex > 0,
                                  color: Appcolors.kprimarycolor,
                                ),

                                // Play Button (Larger with special styling)
                                _buildControlButton(
                                  icon: isPlaying
                                      ? CupertinoIcons.pause_circle_fill
                                      : CupertinoIcons.play_circle_fill,
                                  onPressed: () {
                                    if (isPlaying) {
                                      _audioService.pauseAudio();
                                      setState(() {
                                        isPlaying = false;
                                      });
                                    } else {
                                      _audioService.playAudioFromFile(
                                        '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.mp3}',
                                      );
                                      setState(() {
                                        isPlaying = true;
                                      });
                                    }
                                  },
                                  size: 70,
                                  isEnabled: true,
                                  color: Appcolors.korangeColor,
                                  //isMainButton: true,
                                ),

                                // Stop Button
                                _buildControlButton(
                                  icon: CupertinoIcons.stop_circle_fill,
                                  onPressed: () {
                                    _audioService.stopAudio();
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  },
                                  isEnabled: true,
                                  color: Appcolors.kredcolor,
                                ),

                                // Next Button
                                _buildControlButton(
                                  icon: CupertinoIcons.forward_fill,
                                  onPressed: currentIndex < dataItems.length - 1
                                      ? () {
                                          setState(() {
                                            currentIndex++;
                                          });
                                          _audioService.stopAudio();
                                          _animateItemChange();
                                        }
                                      : null,
                                  isEnabled:
                                      currentIndex < dataItems.length - 1,
                                  color: Appcolors.kprimarycolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(2)),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isEnabled,
    double size = 55,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: isEnabled
            ? (LinearGradient(
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ))
            : LinearGradient(
                colors: [
                  Appcolors.kgreycolor.withOpacity(0.1),
                  Appcolors.kgreycolor.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: isEnabled
              ? color.withOpacity(0.3)
              : Appcolors.kgreycolor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isEnabled ? color : Appcolors.kgreycolor.withOpacity(0.5),
          size: size == 70 ? 45 : 28,
        ),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}
// class ScreenIndividualPage extends StatefulWidget {
//   const ScreenIndividualPage({super.key});

//   @override
//   State<ScreenIndividualPage> createState() => _ScreenIndividualPageState();
// }

// class _ScreenIndividualPageState extends State<ScreenIndividualPage>
//     with TickerProviderStateMixin {
//   final AudioService _audioService = AudioService();
//   late AnimationController _imageAnimationController;
//   late Animation<double> _imageScaleAnimation;

//   int currentIndex = 0;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controller
//     _imageAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     // Setup animation
//     _imageScaleAnimation = Tween<double>(
//       begin: 0.95,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _imageAnimationController,
//       curve: Curves.easeOut,
//     ));

//     // Start animation
//     _imageAnimationController.forward();

//     context
//         .read<FetchdataFromDatabaseBloc>()
//         .add(FetchDataFromDatabaseInitialEvent());
//   }

//   @override
//   void dispose() {
//     _imageAnimationController.dispose();
//     super.dispose();
//   }

//   void _animateItemChange() {
//     _imageAnimationController.reset();
//     _imageAnimationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(
//             CupertinoIcons.arrow_left,
//             color: Colors.black87,
//           ),
//         ),
//         title: Text(
//           'Animals',
//           style: GoogleFonts.poppins(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<FetchdataFromDatabaseBloc, FetchdataFromDatabaseState>(
//         builder: (context, state) {
//           if (state is FetchDataFromDatabaseLoadingState) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text(
//                     'Loading Animals...',
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is FetchDataFromDatabaseSuccessState) {
//             final dataItems = state.dataItems;
//             if (dataItems.isEmpty) {
//               return const Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.pets_outlined,
//                       size: 64,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'No Animals Found',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Check back later for new content',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             final item = dataItems[currentIndex];

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   // Progress indicator
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           '${currentIndex + 1} / ${dataItems.length}',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: LinearProgressIndicator(
//                             value: (currentIndex + 1) / dataItems.length,
//                             backgroundColor: Colors.grey[200],
//                             valueColor: const AlwaysStoppedAnimation<Color>(
//                               Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // Image section
//                   Expanded(
//                     child: AnimatedBuilder(
//                       animation: _imageScaleAnimation,
//                       builder: (context, child) {
//                         return Transform.scale(
//                           scale: _imageScaleAnimation.value,
//                           child: Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: Image.file(
//                                 File(
//                                     '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}'),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // Animal name
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       'Lion',
//                       style: GoogleFonts.poppins(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // Control buttons
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // Previous button
//                         _buildControlButton(
//                           icon: CupertinoIcons.chevron_left,
//                           onPressed: currentIndex > 0
//                               ? () {
//                                   setState(() {
//                                     currentIndex--;
//                                   });
//                                   _audioService.stopAudio();
//                                   _animateItemChange();
//                                 }
//                               : null,
//                         ),

//                         // Play/Pause button
//                         _buildControlButton(
//                           icon: isPlaying
//                               ? CupertinoIcons.pause_circle
//                               : CupertinoIcons.play_circle,
//                           onPressed: () {
//                             if (isPlaying) {
//                               _audioService.pauseAudio();
//                               setState(() {
//                                 isPlaying = false;
//                               });
//                             } else {
//                               _audioService.playAudioFromFile(
//                                 '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.mp3}',
//                               );
//                               setState(() {
//                                 isPlaying = true;
//                               });
//                             }
//                           },
//                           size: 48,
//                           color: Colors.blue,
//                         ),

//                         // Stop button
//                         _buildControlButton(
//                           icon: CupertinoIcons.stop_circle,
//                           onPressed: () {
//                             _audioService.stopAudio();
//                             setState(() {
//                               isPlaying = false;
//                             });
//                           },
//                           color: Colors.red[400],
//                         ),

//                         // Next button
//                         _buildControlButton(
//                           icon: CupertinoIcons.chevron_right,
//                           onPressed: currentIndex < dataItems.length - 1
//                               ? () {
//                                   setState(() {
//                                     currentIndex++;
//                                   });
//                                   _audioService.stopAudio();
//                                   _animateItemChange();
//                                 }
//                               : null,
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),
//                 ],
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   Widget _buildControlButton({
//     required IconData icon,
//     required VoidCallback? onPressed,
//     double size = 40,
//     Color? color,
//   }) {
//     final isEnabled = onPressed != null;
//     final buttonColor = color ?? Colors.grey[600];

//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: isEnabled ? Colors.grey[100] : Colors.grey[50],
//         borderRadius: BorderRadius.circular(size / 2),
//         border: Border.all(
//           color: isEnabled ? Colors.grey[300]! : Colors.grey[200]!,
//           width: 1,
//         ),
//       ),
//       child: IconButton(
//         onPressed: onPressed,
//         icon: Icon(
//           icon,
//           color: isEnabled ? buttonColor : Colors.grey[400],
//           size: size * 0.5,
//         ),
//         padding: EdgeInsets.zero,
//       ),
//     );
//   }
// }
