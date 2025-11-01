// import 'dart:io';
// import 'dart:ui';

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
//       backgroundColor: Appcolors.kwhiteColor,
//       body: BlocBuilder<FetchdataFromDatabaseBloc, FetchdataFromDatabaseState>(
//         builder: (context, state) {
//           if (state is FetchDataFromDatabaseLoadingState) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Appcolors.kprimarycolor.withOpacity(0.1),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: LoadingAnimationWidget.fourRotatingDots(
//                       color: Appcolors.kprimarycolor,
//                       size: 50,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'Loading Animals...',
//                     style: GoogleFonts.poppins(
//                       color: Appcolors.ktextColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is FetchDataFromDatabaseSuccessState) {
//             final dataItems = state.dataItems;
//             if (dataItems.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(30),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Appcolors.kprimarycolor.withOpacity(0.1),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         Icons.pets_outlined,
//                         size: 80,
//                         color: Appcolors.kprimarycolor.withOpacity(0.7),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       'No Animals Found',
//                       style: GoogleFonts.poppins(
//                         color: Appcolors.ktextColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Check back later for new content',
//                       style: GoogleFonts.poppins(
//                         color: Appcolors.khinttextColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             final item = dataItems[currentIndex];

//             return Column(
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15),
//                     ),
//                     gradient: LinearGradient(
//                       colors: [
//                         Appcolors.kprimarycolor,
//                         Appcolors.kgreenlightColor,
//                         Color.fromARGB(255, 129, 199, 193),
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                   padding: EdgeInsets.only(
//                     left: ResponsiveUtils.wp(5),
//                     right: ResponsiveUtils.wp(5),
//                     top: ResponsiveUtils.hp(7),
//                     bottom: ResponsiveUtils.hp(3),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           // Back Button with modern design
//                           Container(
//                             height: ResponsiveUtils.wp(12),
//                             width: ResponsiveUtils.wp(12),
//                             decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 235, 247, 241),
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(
//                                 color: Appcolors.kprimarycolor.withOpacity(0.1),
//                                 width: 1,
//                               ),
//                             ),
//                             child: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 CupertinoIcons.chevron_back,
//                                 color: Appcolors.kprimarycolor,
//                                 size: ResponsiveUtils.wp(8),
//                                 //weight: 50,
//                               ),
//                             ),
//                           ),
//                           ResponsiveSizedBox.width30,
//                           // Beautiful Title with gradient background
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: ResponsiveUtils.wp(20),
//                               vertical: ResponsiveUtils.hp(1.2),
//                             ),
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Appcolors.kprimarycolor,
//                                   Appcolors.kgreenlightColor,
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(25),
//                               border: Border.all(
//                                 color: Appcolors.kwhiteColor,
//                                 width: .1,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color:
//                                       Appcolors.kprimarycolor.withOpacity(0.3),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Text(
//                               'Animals',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: ResponsiveUtils.hp(2.5),
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                           ),

       
//                           ResponsiveSizedBox.width10
//                         ],
//                       ),
//                       ResponsiveSizedBox.height50,
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 10,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Text(
//                               '${currentIndex + 1} / ${dataItems.length}',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: LinearProgressIndicator(
//                                 value: (currentIndex + 1) / dataItems.length,
//                                 backgroundColor: Colors.grey[200],
//                                 valueColor: const AlwaysStoppedAnimation<Color>(
//                                   Appcolors.korangeColor,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: ResponsiveUtils.hp(4)),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       children: [
//                         AnimatedBuilder(
//                           animation: _imageScaleAnimation,
//                           builder: (context, child) {
//                             return Transform.scale(
//                               scale: _imageScaleAnimation.value,
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: ResponsiveUtils.wp(2),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Appcolors.korangBorderColor
//                                       .withOpacity(.2),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color:
//                                         Appcolors.korangeColor.withOpacity(.4),
//                                     width: 1.5,
//                                   ),
//                                 ),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(12),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(20),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Colors.transparent,
//                                             Appcolors.kprimarycolor
//                                                 .withOpacity(0.03),
//                                           ],
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                         ),
//                                       ),
//                                       child: Image.file(
//                                         File(
//                                             '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}'),
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                         height: ResponsiveUtils.hp(30),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         SizedBox(height: ResponsiveUtils.hp(4)),

//                         // Enhanced Animal Name with gradient background
//                         SlideTransition(
//                           position: _slideAnimation,
//                           child: FadeTransition(
//                             opacity: _fadeAnimation,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: BackdropFilter(
//                                 filter:
//                                     ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//                                 child: Container(
//                                   margin: EdgeInsets.symmetric(
//                                     horizontal: ResponsiveUtils.wp(2),
//                                   ),
//                                   width: double.infinity,
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: ResponsiveUtils.wp(10),
//                                     vertical: ResponsiveUtils.hp(1.5),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Appcolors.kprimarycolor.withOpacity(
//                                         0.2), // More visible background
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color: Appcolors.kprimarycolor,
//                                       width: .8,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Lion',
//                                     style: GoogleFonts.poppins(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: ResponsiveUtils.hp(2.8),
//                                       letterSpacing: 1.2,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: ResponsiveUtils.hp(4)),

//                         // Enhanced Progress Bar with modern styling

//                         SizedBox(height: ResponsiveUtils.hp(1)),

//                         // Enhanced Control Buttons with modern design
//                         SlideTransition(
//                           position: _slideAnimation,
//                           child: FadeTransition(
//                             opacity: _fadeAnimation,
//                             child: Container(
//                               margin: EdgeInsets.symmetric(
//                                 horizontal: ResponsiveUtils.wp(2),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: ResponsiveUtils.wp(3),
//                                 vertical: ResponsiveUtils.hp(2),
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Appcolors.kgreenlightColor,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   // Previous Button
//                                   _buildControlButton(
//                                     icon: CupertinoIcons.backward_fill,
//                                     onPressed: currentIndex > 0
//                                         ? () {
//                                             setState(() {
//                                               currentIndex--;
//                                             });
//                                             _audioService.stopAudio();
//                                             _animateItemChange();
//                                           }
//                                         : null,
//                                     isEnabled: currentIndex > 0,
//                                     color: Appcolors.kprimarycolor,
//                                   ),

//                                   // Play Button (Larger with special styling)
//                                   _buildControlButton(
//                                     icon: isPlaying
//                                         ? CupertinoIcons.pause_circle_fill
//                                         : CupertinoIcons.play_circle_fill,
//                                     onPressed: () {
//                                       if (isPlaying) {
//                                         _audioService.pauseAudio();
//                                         setState(() {
//                                           isPlaying = false;
//                                         });
//                                       } else {
//                                         _audioService.playAudioFromFile(
//                                           '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.mp3}',
//                                         );
//                                         setState(() {
//                                           isPlaying = true;
//                                         });
//                                       }
//                                     },
//                                     size: 70,
//                                     isEnabled: true,
//                                     color: Appcolors.korangeColor,
//                                     //isMainButton: true,
//                                   ),

//                                   // Stop Button
//                                   _buildControlButton(
//                                     icon: CupertinoIcons.stop_circle_fill,
//                                     onPressed: () {
//                                       _audioService.stopAudio();
//                                       setState(() {
//                                         isPlaying = false;
//                                       });
//                                     },
//                                     isEnabled: true,
//                                     color: Appcolors.kredcolor,
//                                   ),

//                                   // Next Button
//                                   _buildControlButton(
//                                     icon: CupertinoIcons.forward_fill,
//                                     onPressed:
//                                         currentIndex < dataItems.length - 1
//                                             ? () {
//                                                 setState(() {
//                                                   currentIndex++;
//                                                 });
//                                                 _audioService.stopAudio();
//                                                 _animateItemChange();
//                                               }
//                                             : null,
//                                     isEnabled:
//                                         currentIndex < dataItems.length - 1,
//                                     color: Appcolors.kprimarycolor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: ResponsiveUtils.hp(2)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
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
//     required Color color,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: isEnabled
//             ? (LinearGradient(
//                 colors: [
//                   color.withOpacity(0.1),
//                   color.withOpacity(0.05),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ))
//             : LinearGradient(
//                 colors: [
//                   Appcolors.kgreycolor.withOpacity(0.1),
//                   Appcolors.kgreycolor.withOpacity(0.05),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//         borderRadius: BorderRadius.circular(size / 2),
//         border: Border.all(
//           color: isEnabled
//               ? color.withOpacity(0.3)
//               : Appcolors.kgreycolor.withOpacity(0.2),
//           width: 1,
//         ),
//         boxShadow: isEnabled
//             ? [
//                 BoxShadow(
//                   color: color.withOpacity(0.2),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ]
//             : null,
//       ),
//       child: IconButton(
//         onPressed: onPressed,
//         icon: Icon(
//           icon,
//           color: isEnabled ? color : Appcolors.kgreycolor.withOpacity(0.5),
//           size: size == 70 ? 45 : 28,
//         ),
//         padding: const EdgeInsets.all(8),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:ui';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/widgets/audio_service.dart';


class ScreenIndividualPage extends StatefulWidget {
  final List<Map<String, dynamic>> contents;
  final String categoryName;

  const ScreenIndividualPage({
    super.key,
    required this.contents,
    required this.categoryName,
  });

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


    // Debug: Log the contents received
    log('=== INDIVIDUAL PAGE INITIALIZED ===');
    log('Category: ${widget.categoryName}');
    log('Total contents: ${widget.contents.length}');
    
    if (widget.contents.isNotEmpty) {
      final firstItem = widget.contents[0];
      log('First item sample:');
      log('  Content: ${firstItem['content']}');
      log('  Image Path: ${firstItem['contentImage']}');
      log('  Audio Path: ${firstItem['contentAudio']}');
      log('  Reference Audio: ${firstItem['referenceAudio']}');
      
      // Verify file existence
      _verifyFiles(firstItem);
    }

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
  _playReferenceAudioForCurrentItem();
});

  }

  // Verify file existence for debugging
  void _verifyFiles(Map<String, dynamic> item) {
    final imageFile = File(item['contentImage']);
    final audioFile = File(item['contentAudio']);
    final refAudioFile = File(item['referenceAudio']);
    
    log('File verification:');
    log('  Image exists: ${imageFile.existsSync()} - ${item['contentImage']}');
    log('  Audio exists: ${audioFile.existsSync()} - ${item['contentAudio']}');
    log('  Ref Audio exists: ${refAudioFile.existsSync()} - ${item['referenceAudio']}');
  }

  @override
  void dispose() {
    _audioService.dispose();
    _imageAnimationController.dispose();
    _controlsAnimationController.dispose();
    super.dispose();
  }

  void _animateItemChange() {
    _imageAnimationController.reset();
    _imageAnimationController.forward();
    
    // Verify files when changing items
    if (currentIndex < widget.contents.length) {
      log('=== CHANGING TO INDEX $currentIndex ===');
      _verifyFiles(widget.contents[currentIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contents.isEmpty) {
      return Scaffold(
        backgroundColor: Appcolors.kwhiteColor,
        body: Center(
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
                  Icons.content_paste_off_rounded,
                  size: 80,
                  color: Appcolors.kprimarycolor.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No Content Found',
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

    final item = widget.contents[currentIndex];

    return Scaffold(
      backgroundColor: Appcolors.kwhiteColor,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                colors: [
                  Appcolors.kprimarycolor,
                  Appcolors.kgreenlightColor,
                  Color.fromARGB(255, 129, 199, 193),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.only(
              left: ResponsiveUtils.wp(5),
              right: ResponsiveUtils.wp(5),
              top: ResponsiveUtils.hp(7),
              bottom: ResponsiveUtils.hp(3),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Back Button with modern design
                    Container(
                      height: ResponsiveUtils.wp(12),
                      width: ResponsiveUtils.wp(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 235, 247, 241),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Appcolors.kprimarycolor.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _audioService.stopAudio();
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.chevron_back,
                          color: Appcolors.kprimarycolor,
                          size: ResponsiveUtils.wp(8),
                        ),
                      ),
                    ),
                    ResponsiveSizedBox.width30,
                    // Beautiful Title with gradient background
                    Expanded(
                      child: Container(
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
                          border: Border.all(
                            color: Appcolors.kwhiteColor,
                            width: .1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolors.kprimarycolor.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          widget.categoryName,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: ResponsiveUtils.hp(2.2),
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    ResponsiveSizedBox.width10
                  ],
                ),
                ResponsiveSizedBox.height50,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${currentIndex + 1} / ${widget.contents.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (currentIndex + 1) / widget.contents.length,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Appcolors.korangeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveUtils.hp(4)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _imageScaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _imageScaleAnimation.value,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.wp(2),
                          ),
                          decoration: BoxDecoration(
                            color:
                                Appcolors.korangBorderColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Appcolors.korangeColor.withOpacity(.4),
                              width: 1.5,
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
                                  File(item['contentImage']),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: ResponsiveUtils.hp(30),
                                  errorBuilder: (context, error, stackTrace) {
                                    // Enhanced error logging
                                    log('=== IMAGE LOAD ERROR ===');
                                    log('Failed to load: ${item['contentImage']}');
                                    log('Error: $error');
                                    log('File exists: ${File(item['contentImage']).existsSync()}');
                                    
                                    return Container(
                                      height: ResponsiveUtils.hp(30),
                                      color: Colors.grey[200],
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.broken_image_outlined,
                                            size: 60,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Image not found',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            item['content'] ?? '',
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: ResponsiveUtils.hp(4)),

                  // Enhanced Content Name with gradient background
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(2),
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(10),
                              vertical: ResponsiveUtils.hp(1.5),
                            ),
                            decoration: BoxDecoration(
                              color: Appcolors.kprimarycolor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Appcolors.kprimarycolor,
                                width: .8,
                              ),
                            ),
                            child: Text(
                              item['content'] ?? 'Unknown',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveUtils.hp(2.8),
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.hp(4)),

                  // Enhanced Control Buttons with modern design
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(2),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(3),
                          vertical: ResponsiveUtils.hp(2),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Appcolors.kgreenlightColor,
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
                                  ? () async{
               setState(() {
          currentIndex--;
          isPlaying = false;
        });
        await _audioService.stopAudio();
        _animateItemChange();
        Future.delayed(const Duration(milliseconds: 400), () {
          _playReferenceAudioForCurrentItem();
        });                         // setState(() {
                                      //   currentIndex--;
                                      //   isPlaying = false;
                                      // });
                                      // _audioService.stopAudio();
                                      // _animateItemChange();
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
                              onPressed: ()async {
                                final item = widget.contents[currentIndex];
  final contentAudioPath = item['contentAudio'];

  if (contentAudioPath.isEmpty) {
    log('⚠️ No content audio found for item $currentIndex');
    return;
  }

  final file = File(contentAudioPath);
  if (!file.existsSync()) {
    log('❌ Content audio file not found: $contentAudioPath');
    return;
  }

  if (isPlaying) {
    await _audioService.pauseAudio();
    setState(() => isPlaying = false);
  } else {
    log('▶️ Playing content audio: $contentAudioPath');
    await _audioService.stopAudio(); // stop any previous sound
    await _audioService.playAudioFromFile(contentAudioPath);
    setState(() => isPlaying = true);
  }
                    
                              },
                              size: 70,
                              isEnabled: true,
                              color: Appcolors.korangeColor,
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
                              onPressed:
                                  currentIndex < widget.contents.length - 1
                                      ? () async{
                            
                setState(() {
          currentIndex++;
          isPlaying = false;
        });
        await _audioService.stopAudio();
        _animateItemChange();
        Future.delayed(const Duration(milliseconds: 400), () {
          _playReferenceAudioForCurrentItem();
        });
                                        }
                                      : null,
                              isEnabled:
                                  currentIndex < widget.contents.length - 1,
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
        ],
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
  /////////////////////
void _playReferenceAudioForCurrentItem() async {
  if (widget.contents.isEmpty) return;

  final item = widget.contents[currentIndex];
  final refAudioPath = item['referenceAudio'];

  if (refAudioPath.isEmpty) {
    log('⚠️ No reference audio found for index $currentIndex');
    return;
  }

  final file = File(refAudioPath);
  if (!file.existsSync()) {
    log('❌ Reference audio file not found: $refAudioPath');
    return;
  }

  log('🎧 Auto playing reference audio for item $currentIndex');
  await _audioService.stopAudio(); // stop any playing sound
  await _audioService.playAudioFromFile(refAudioPath);
}


}