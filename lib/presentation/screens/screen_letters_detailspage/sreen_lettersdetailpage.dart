
import 'dart:ui';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/alphabet_model.dart';
import 'package:langlex/presentation/blocs/alphabet_details_bloc/alphabets_details_bloc.dart';
import 'package:langlex/presentation/widgets/audio_service.dart';


class ScreenAlphabetDetailsPage extends StatefulWidget {
  final String alphabet;
  final String categoryName;

  const ScreenAlphabetDetailsPage({
    super.key,
    required this.alphabet,
    required this.categoryName,
  });

  @override
  State<ScreenAlphabetDetailsPage> createState() => _ScreenAlphabetDetailsPageState();
}

class _ScreenAlphabetDetailsPageState extends State<ScreenAlphabetDetailsPage>
    with TickerProviderStateMixin {
  final AudioService _audioService = AudioService();
  late AnimationController _imageAnimationController;
  late AnimationController _controlsAnimationController;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int currentIndex = 0;
  bool isPlaying = false;
  List<AlphabetModel> alphabetList = [];

  @override
  void initState() {
    super.initState();

    log('=== ALPHABET DETAILS PAGE INITIALIZED ===');
    log('Alphabet: ${widget.alphabet}');
    log('Category: ${widget.categoryName}');

    // Trigger the BLoC event to fetch data
    context.read<AlphabetsDetailsBloc>().add(
          AlphabetsDetailsFetchingInitialEvent(alphabet: widget.alphabet),
        );

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
  }

  void _playAudioForCurrentItem() async {
    if (alphabetList.isEmpty) return;

    final item = alphabetList[currentIndex];
    final audioPath = item.audio;

    if (audioPath.isEmpty || audioPath == 'NA') {
      log('⚠️ No audio found for index $currentIndex');
      return;
    }

    log('🎧 Auto playing audio for item $currentIndex: $audioPath');
    await _audioService.stopAudio();
    await _audioService.playAudioFromFile('${Endpoints.imagebaseUrl}$audioPath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kwhiteColor,
      body: BlocConsumer<AlphabetsDetailsBloc, AlphabetsDetailsState>(
        listener: (context, state) {
          if (state is AlphabetsDetailsSuccessState) {
            setState(() {
              alphabetList = state.letters;
              currentIndex = 0;
              isPlaying = false;
            });

            // Start animations and play audio
            _imageAnimationController.forward();
            _controlsAnimationController.forward();
            
            Future.delayed(const Duration(milliseconds: 400), () {
              _playAudioForCurrentItem();
            });
          }
        },
        builder: (context, state) {
          if (state is AlphaetsDetailsLoadingState) {
            return _buildLoadingState();
          }

          if (state is AlphabetsDetailsErrorState) {
            return _buildErrorState(state.message);
          }

          if (alphabetList.isEmpty) {
            return _buildEmptyState();
          }

          return _buildContentView();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Appcolors.kprimarycolor),
          ),
          SizedBox(height: ResponsiveUtils.hp(2)),
          Text(
            'Loading alphabet data...',
            style: GoogleFonts.poppins(
              color: Appcolors.kprimarycolor,
              fontSize: ResponsiveUtils.hp(2),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
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
                  color: Appcolors.korangeColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: Appcolors.korangeColor.withOpacity(0.7),
            ),
          ),
          SizedBox(height: ResponsiveUtils.hp(3)),
          Text(
            'Oops! Something went wrong',
            style: GoogleFonts.poppins(
              color: Appcolors.kblackColor,
              fontSize: ResponsiveUtils.hp(2.2),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ResponsiveUtils.hp(1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(10)),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                color: Appcolors.kblackColor.withOpacity(0.6),
                fontSize: ResponsiveUtils.hp(1.6),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: ResponsiveUtils.hp(3)),
          ElevatedButton(
            onPressed: () {
              context.read<AlphabetsDetailsBloc>().add(
                    AlphabetsDetailsFetchingInitialEvent(alphabet: widget.alphabet),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.kprimarycolor,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(8),
                vertical: ResponsiveUtils.hp(1.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Try Again',
              style: GoogleFonts.poppins(
                color: Appcolors.kwhiteColor,
                fontSize: ResponsiveUtils.hp(1.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
          SizedBox(height: ResponsiveUtils.hp(3)),
          Text(
            'No Content Found',
            style: GoogleFonts.poppins(
              color: Appcolors.kblackColor,
              fontSize: ResponsiveUtils.hp(2.2),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ResponsiveUtils.hp(1)),
          Text(
            'Check back later for new content',
            style: GoogleFonts.poppins(
              color: Appcolors.kblackColor.withOpacity(0.6),
              fontSize: ResponsiveUtils.hp(1.6),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentView() {
    final item = alphabetList[currentIndex];


    return Column(
      children: [
        // Header Section - Same as original
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
                  // Back Button
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
                  // Title
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
                  ResponsiveSizedBox.width10,
                ],
              ),
              ResponsiveSizedBox.height50,
              // Progress Indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      '${currentIndex + 1} / ${alphabetList.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (currentIndex + 1) / alphabetList.length,
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
        
        // Content Section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Image Display - Same structure as original
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
                          color: Appcolors.korangBorderColor.withOpacity(.2),
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
                                    Appcolors.kprimarycolor.withOpacity(0.03),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.network(
                                '${Endpoints.imagebaseUrl}${item.picture}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: ResponsiveUtils.hp(30),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: ResponsiveUtils.hp(30),
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Appcolors.kprimarycolor,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  log('=== IMAGE LOAD ERROR ===');
                                  log('Failed to load: ${item.picture}');
                                  log('Error: $error');
                                  
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
                                          item.illWord,
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

                // Word and Letter Display
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Large Letter
                              Text(
                                item.alphabet,
                                style: GoogleFonts.poppins(
                                  color: Appcolors.kprimarycolor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: ResponsiveUtils.hp(4.5),
                                  letterSpacing: 2,
                                ),
                              ),
                              SizedBox(width: ResponsiveUtils.wp(4)),
                              // Divider
                              Container(
                                height: ResponsiveUtils.hp(4),
                                width: 2,
                                color: Appcolors.kprimarycolor.withOpacity(0.5),
                              ),
                              SizedBox(width: ResponsiveUtils.wp(4)),
                              // Word
                              Text(
                                item.illWord,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: ResponsiveUtils.hp(2.8),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(4)),

                // Control Buttons - Same structure as original
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
                                ? () async {
                                    setState(() {
                                      currentIndex--;
                                      isPlaying = false;
                                    });
                                    await _audioService.stopAudio();
                                    _animateItemChange();
                                    Future.delayed(
                                      const Duration(milliseconds: 400),
                                      () {
                                        _playAudioForCurrentItem();
                                      },
                                    );
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
                            onPressed: () async {
                              final wordAudioPath = item.wordAudio;

                              if (wordAudioPath.isEmpty || wordAudioPath == 'NA') {
                                log('⚠️ No word audio found for item $currentIndex');
                                return;
                              }

                              if (isPlaying) {
                                await _audioService.pauseAudio();
                                setState(() => isPlaying = false);
                              } else {
                                log('▶️ Playing word audio: ${Endpoints.imagebaseUrl}$wordAudioPath');
                                await _audioService.stopAudio();
                                await _audioService.playAudioFromFile('${Endpoints.imagebaseUrl}$wordAudioPath');
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
                            onPressed: currentIndex < alphabetList.length - 1
                                ? () async {
                                    setState(() {
                                      currentIndex++;
                                      isPlaying = false;
                                    });
                                    await _audioService.stopAudio();
                                    _animateItemChange();
                                    Future.delayed(
                                      const Duration(milliseconds: 400),
                                      () {
                                        _playAudioForCurrentItem();
                                      },
                                    );
                                  }
                                : null,
                            isEnabled: currentIndex < alphabetList.length - 1,
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
            ? LinearGradient(
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  Colors.grey.withOpacity(0.1),
                  Colors.grey.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: isEnabled
              ? color.withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
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
          color: isEnabled ? color : Colors.grey.withOpacity(0.5),
          size: size == 70 ? 45 : 28,
        ),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}