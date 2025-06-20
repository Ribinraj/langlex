// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';
// import 'package:langlex/core/responsive_utils.dart';
// import 'package:langlex/presentation/blocs/Fetch_data_from_database/fetchdata_from_database_bloc.dart';
// import 'package:langlex/presentation/widgets/audio_service.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// class ScreenIndividualPage extends StatefulWidget {
//   const ScreenIndividualPage({super.key});

//   @override
//   State<ScreenIndividualPage> createState() => _ScreenIndividualPageState();
// }

// class _ScreenIndividualPageState extends State<ScreenIndividualPage> {
//   final AudioService _audioService = AudioService();

//   int currentIndex = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context
//         .read<FetchdataFromDatabaseBloc>()
//         .add(FetchDataFromDatabaseInitialEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<FetchdataFromDatabaseBloc, FetchdataFromDatabaseState>(
//         builder: (context, state) {
//           if (state is FetchDataFromDatabaseLoadingState) {
//             return Center(
//               child: LoadingAnimationWidget.fourRotatingDots(
//                   color: Appcolors.kgreenColor, size: 40),
//             );
//           } else if (state is FetchDataFromDatabaseSuccessState) {
//             final dataItems = state.dataItems;
//             log(dataItems.length.toString());
//             if (dataItems.isEmpty) {
//               return const Center(
//                 child: Text('No items To display'),
//               );
//             }
//             final item = dataItems[currentIndex];
//             return Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   opacity: .15,
//                   image: AssetImage(
//                       profilebackgroundimage), // Correct way to use asset image
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                 child: Column(
//                   children: [
//                     ResponsiveSizedBox.height50,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: const Icon(
//                             CupertinoIcons.arrowshape_turn_up_left_circle_fill,
//                             color: Appcolors.kgreenColor,
//                             size: 45,
//                           ),
//                         ),
//                         Text(
//                           'Animals',
//                           style: GoogleFonts.playpenSans(
//                               textStyle: TextStyle(
//                                   color: Appcolors.kgreenColor,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: ResponsiveUtils.hp(3.5))),
//                         ),
//                         CircularPercentIndicator(
//                           radius: 20.0,
//                           center: Text(
//                             "${((currentIndex + 1) / dataItems.length * 100).toInt()}%",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 12),
//                           ),
//                           lineWidth: 3.0,
//                           animation: true,
//                           percent: (currentIndex + 1) / dataItems.length,
//                           circularStrokeCap: CircularStrokeCap.round,
//                           progressColor: Appcolors.kgreenColor,
//                         ),
//                       ],
//                     ),
//                     ResponsiveSizedBox.height30,
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                             10), // Set the desired border radius
//                         border: Border.all(
//                           color: Appcolors.kgreenColor.withOpacity(.7),
//                           // Set the desired border color
//                           width: 2, // Set the border width
//                         ),
//                       ),

//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.file(
//                           File(
//                               '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}'),
//                           fit: BoxFit.cover,
//                           height: ResponsiveUtils.hp(50),
//                           //width: ResponsiveUtils.wp(40),
//                         ),
//                       ),
//                     ),
//                     ResponsiveSizedBox.height20,
//                     Text(
//                       'Leopard',
//                       style: GoogleFonts.playpenSans(
//                           textStyle: const TextStyle(
//                               color: Appcolors.kgreenColor,
//                               fontWeight: FontWeight.w600),
//                           fontSize: ResponsiveUtils.hp(4)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             onPressed: currentIndex > 0
//                                 ? () {
//                                     setState(() {
//                                       currentIndex--;
//                                     });
//                                     _audioService.stopAudio();
//                                   }
//                                 : null,
//                             icon: const Icon(
//                               CupertinoIcons
//                                   .arrowshape_turn_up_left_circle_fill,
//                               color: Appcolors.kgreenColor,
//                               size: 55,
//                             ),
//                           ),

//                           IconButton(
//                             onPressed: () {
//                               _audioService.playAudioFromFile(
//                                   '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.mp3}');
//                             },
//                             icon: const Icon(
//                               CupertinoIcons.play_circle_fill,
//                               color: Appcolors.kgreenColor,
//                               size: 55,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               _audioService.pauseAudio();
//                             },
//                             icon: const Icon(
//                               CupertinoIcons.pause_circle_fill,
//                               color: Appcolors.kgreenColor,
//                               size: 55,
//                             ),
//                           ),
//                           // InkWell(
//                           //   onTap: () {},
//                           //   child: Image.asset(
//                           //     'assets/images/arrow next.png',
//                           //     fit: BoxFit.cover,
//                           //     height: h(context) * .1,
//                           //     // width: w(context) * .2,
//                           //   ),
//                           // ),
//                           IconButton(
//                             onPressed: currentIndex < dataItems.length - 1
//                                 ? () {
//                                     setState(() {
//                                       currentIndex++;
//                                     });
//                                     _audioService.stopAudio();
//                                   }
//                                 : null,
//                             icon: const Icon(
//                               CupertinoIcons
//                                   .arrowshape_turn_up_right_circle_fill,
//                               color: Appcolors.kgreenColor,
//                               size: 55,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text('Item ${currentIndex + 1} of ${dataItems.length}'),
//                     ResponsiveSizedBox.height10,
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
/////////////////////////////////////
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/Fetch_data_from_database/fetchdata_from_database_bloc.dart';
import 'package:langlex/presentation/screens/individual_contentpage/widgets/progressindicator.dart';
import 'package:langlex/presentation/widgets/audio_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// class ScreenIndividualPage extends StatefulWidget {
//   const ScreenIndividualPage({super.key});

//   @override
//   State<ScreenIndividualPage> createState() => _ScreenIndividualPageState();
// }

// class _ScreenIndividualPageState extends State<ScreenIndividualPage> {
//   final AudioService _audioService = AudioService();

//   int currentIndex = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context
//         .read<FetchdataFromDatabaseBloc>()
//         .add(FetchDataFromDatabaseInitialEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<FetchdataFromDatabaseBloc, FetchdataFromDatabaseState>(
//         builder: (context, state) {
//           if (state is FetchDataFromDatabaseLoadingState) {
//             return Center(
//               child: LoadingAnimationWidget.fourRotatingDots(
//                   color: Appcolors.kgreenColor, size: 40),
//             );
//           } else if (state is FetchDataFromDatabaseSuccessState) {
//             final dataItems = state.dataItems;
//             log(dataItems.length.toString());
//             if (dataItems.isEmpty) {
//               return const Center(
//                 child: Text('No items To display'),
//               );
//             }
//             final item = dataItems[currentIndex];
//             return Container(
//               padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Appcolors.kgreenColor,
//                     Color.fromARGB(255, 99, 233, 179)
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 // image: DecorationImage(
//                 //   opacity: .15,
//                 //   image: AssetImage(profilebackgroundimage),
//                 //   fit: BoxFit.cover,
//                 // ),
//               ),
//               child: Column(
//                 children: [
//                   ResponsiveSizedBox.height50,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           CupertinoIcons.arrowshape_turn_up_left_circle_fill,
//                           color: Appcolors.kwhiteColor,
//                           size: ResponsiveUtils.wp(11),
//                         ),
//                       ),
//                       Text(
//                         'Animals',
//                         style: GoogleFonts.playpenSans(
//                             textStyle: TextStyle(
//                                 color: Appcolors.kwhiteColor,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: ResponsiveUtils.hp(3.2))),
//                       ),
//                       CircularPercentIndicator(
//                         radius: ResponsiveUtils.wp(5),
//                         center: Text(
//                           "${((currentIndex + 1) / dataItems.length * 100).toInt()}%",
//                           style: const TextStyle(
//                               color: Appcolors.kwhiteColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12),
//                         ),
//                         lineWidth: 3.0,
//                         animation: true,
//                         percent: (currentIndex + 1) / dataItems.length,
//                         circularStrokeCap: CircularStrokeCap.round,
//                         progressColor: Appcolors.kwhiteColor,
//                       ),
//                     ],
//                   ),
//                   ResponsiveSizedBox.height30,
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(
//                           '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}'),
//                       fit: BoxFit.cover,
//                       height: ResponsiveUtils.hp(32),
//                       //width: ResponsiveUtils.wp(40),
//                     ),
//                   ),
//                   ResponsiveSizedBox.height20,
//                   Text(
//                     'Leopard',
//                     style: GoogleFonts.playpenSans(
//                         textStyle: const TextStyle(
//                             color: Appcolors.kwhiteColor,
//                             fontWeight: FontWeight.w600),
//                         fontSize: ResponsiveUtils.hp(4)),
//                   ),
//                   SizedBox(
//                     height: ResponsiveUtils.hp(7),
//                   ),
//                   TweenAnimationBuilder(
//                     duration: const Duration(milliseconds: 300),
//                     tween: Tween<double>(
//                         begin: 0, end: (currentIndex + 1) / dataItems.length),
//                     builder: (context, double value, child) {
//                       return MusicProgressBar(
//                         progress: value,
//                         activeColor: Appcolors.kwhiteColor,
//                         inactiveColor: Appcolors.kwhiteColor.withOpacity(0.3),
//                         height: 3.0,
//                         dotSize: 8.0,
//                       );
//                     },
//                   ),
//                   SizedBox(
//                     height: ResponsiveUtils.hp(7),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         onPressed: currentIndex > 0
//                             ? () {
//                                 setState(() {
//                                   currentIndex--;
//                                 });
//                                 _audioService.stopAudio();
//                               }
//                             : null,
//                         icon: const Icon(
//                           CupertinoIcons.arrowshape_turn_up_left_circle_fill,
//                           color: Appcolors.kwhiteColor,
//                           size: 55,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _audioService.playAudioFromFile(
//                               '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.mp3}');
//                         },
//                         icon: const Icon(
//                           CupertinoIcons.play_circle_fill,
//                           color: Appcolors.kwhiteColor,
//                           size: 55,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _audioService.pauseAudio();
//                         },
//                         icon: const Icon(
//                           CupertinoIcons.pause_circle_fill,
//                           color: Appcolors.kwhiteColor,
//                           size: 55,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: currentIndex < dataItems.length - 1
//                             ? () {
//                                 setState(() {
//                                   currentIndex++;
//                                 });
//                                 _audioService.stopAudio();
//                               }
//                             : null,
//                         icon: const Icon(
//                           CupertinoIcons.arrowshape_turn_up_right_circle_fill,
//                           color: Appcolors.kwhiteColor,
//                           size: 55,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // const SizedBox(
//                   //   height: 10,
//                   // ),
//                   // Text('Item ${currentIndex + 1} of ${dataItems.length}'),
//                   // ResponsiveSizedBox.height10,
//                 ],
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
////////////////////////
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
                    Color.fromARGB(255, 71, 158, 133), // kgreenColor
                    Color.fromARGB(255, 107, 197, 172), // kgreenlightColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.white,
                      size: 50,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading...',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
                      Color.fromARGB(255, 71, 158, 133),
                      Color.fromARGB(255, 107, 197, 172),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 80,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'No items to display',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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
                    Color.fromARGB(255, 71, 158, 133), // kgreenColor
                    Color.fromARGB(255, 107, 197, 172), // kgreenlightColor
                    Color.fromARGB(255, 138, 124, 108), // korangeColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.7, 1.0],
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
                            // Back Button with Glassmorphism
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Colors.white,
                                  size: ResponsiveUtils.wp(6),
                                ),
                              ),
                            ),

                            // Beautiful Title
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(6),
                                vertical: ResponsiveUtils.hp(1),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Animals',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ResponsiveUtils.hp(2.5),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),

                            // Enhanced Progress Indicator
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: CircularPercentIndicator(
                                radius: ResponsiveUtils.wp(6),
                                center: Text(
                                  "${((currentIndex + 1) / dataItems.length * 100).toInt()}%",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                lineWidth: 4.0,
                                animation: true,
                                animationDuration: 800,
                                percent: (currentIndex + 1) / dataItems.length,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.white,
                                backgroundColor: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(3)),

                      // Enhanced Image Card with Animation
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
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17),
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

                      // Enhanced Animal Name
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(8),
                              vertical: ResponsiveUtils.hp(1.5),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Lion', // You can make this dynamic: item.name
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveUtils.hp(3.5),
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(4)),

                      // Enhanced Progress Bar
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(4)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${currentIndex + 1}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${dataItems.length}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TweenAnimationBuilder(
                                  duration: const Duration(milliseconds: 600),
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: (currentIndex + 1) / dataItems.length,
                                  ),
                                  builder: (context, double value, child) {
                                    return Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: LinearProgressIndicator(
                                          value: value,
                                          backgroundColor: Colors.transparent,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(4)),

                      // Enhanced Control Buttons
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(4),
                              vertical: ResponsiveUtils.hp(2),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
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
                                ),

                                // Play Button (Larger)
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
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isEnabled
            ? Colors.white.withOpacity(0.2)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: Colors.white.withOpacity(isEnabled ? 0.4 : 0.2),
          width: 1,
        ),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isEnabled ? Colors.white : Colors.white.withOpacity(0.5),
          size: size == 70 ? 50 : 30,
        ),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}
