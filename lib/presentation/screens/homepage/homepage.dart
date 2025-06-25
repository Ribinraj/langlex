// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_locales/flutter_locales.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';
// import 'package:langlex/core/responsive_utils.dart';
// import 'package:langlex/presentation/blocs/Content_download_bloc/content_download_bloc.dart';
// import 'package:langlex/presentation/screens/homepage/widgets/custom_appbar.dart';
// import 'package:langlex/presentation/screens/individual_contentpage/individualpage.dart';
// import 'package:langlex/presentation/widgets/custom_navigation.dart';
// import 'package:langlex/presentation/widgets/custom_profile_image.dart';

// import 'package:loading_animation_widget/loading_animation_widget.dart';

// // ignore: must_be_immutable
// class ScreenHomePage extends StatefulWidget {
//   ScreenHomePage({super.key});

//   @override
//   State<ScreenHomePage> createState() => _ScreenHomePageState();
// }

// class _ScreenHomePageState extends State<ScreenHomePage> {
//   List caroselimages = [
//     'assets/images/carosel1.jpg',
//     'assets/images/carosel2.jpg',
//     'assets/images/carosel3.jpg',
//     'assets/images/carosel4.jpg'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Check download status when screen loads
//     context.read<ContentDownloadBloc>().add(CheckDownloadStatusEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//     return Scaffold(
//       backgroundColor: Appcolors.kbackgroundcolor,
//       key: scaffoldKey,
//       endDrawer: CustomDrawer(),
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Appcolors.kprimarycolor,
//                 Color.fromARGB(255, 75, 209, 155)
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         surfaceTintColor: const Color.fromARGB(255, 66, 178, 146),
//         elevation: 0,
//         toolbarHeight: 60,
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CustomRoundImage(
//               circleContainerSize: 45,
//               imageUrl:
//                   'https://anakoskaphotography.com/wp-content/uploads/2018/09/outdoor-children-photo-of-a-girl.jpg',
//             ),
//           ],
//         ),
//         actions: [
//           const DropdownExample(),
//           IconButton(
//             icon: const Icon(
//               Icons.menu,
//               color: Appcolors.kwhiteColor,
//               size: 25,
//             ),
//             onPressed: () {
//               scaffoldKey.currentState?.openEndDrawer();
//             },
//           ),
//           ResponsiveSizedBox.height10,
//         ],
//       ),
//       body: ListView(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Appcolors.kprimarycolor,
//                   Color.fromARGB(255, 99, 233, 179)
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(15),
//                 bottomRight: Radius.circular(15)
//               )
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Stack(
//                 children: [
//                   Image.asset(
//                     'assets/images/back-school-background.png',
//                     height: ResponsiveUtils.hp(28),
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   Positioned(
//                     top: ResponsiveUtils.hp(6),
//                     left: ResponsiveUtils.wp(5),
//                     child: Text(
//                       "Play, learn, and\ngrow together!",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.fredoka(
//                         fontSize: ResponsiveUtils.wp(5.5),
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 3.0,
//                             color: Colors.black.withOpacity(0.5),
//                             offset: const Offset(2, 2),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ResponsiveSizedBox.height10,
//           Padding(
//             padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//             child: BlocConsumer<ContentDownloadBloc, ContentDownloadState>(
//               listener: (context, state) {
//                 if (state is ContentDownloadErrorState) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Download failed: ${state.error}'),
//                       backgroundColor: Colors.red,
//                       action: SnackBarAction(
//                         label: 'Retry',
//                         textColor: Colors.white,
//                         onPressed: () {
//                           context.read<ContentDownloadBloc>().add(DownloadButtonClickEvent());
//                         },
//                       ),
//                     ),
//                   );
//                 }

//               },
//               builder: (context, state) {
//                 return _buildContentGrid(state);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildContentGrid(ContentDownloadState state) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         childAspectRatio: 2 / 2,
//       ),
//       shrinkWrap: true,
//       itemCount: 1,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         return _buildGridItem(state);
//       },
//     );
//   }

//   Widget _buildGridItem(ContentDownloadState state) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: _buildMainContainer(state),
//         ),
//         Positioned(
//           top: ResponsiveUtils.hp(2),
//           right: ResponsiveUtils.wp(2),
//           child: _buildActionButton(state),
//         ),
//       ],
//     );
//   }

//   Widget _buildMainContainer(ContentDownloadState state) {
//     final isDownloaded = state is ContentDownloadSuccessState;
//     final isLoading = state is ContentDownloadLoading;

//     return InkWell(
//       onTap: isDownloaded ? () {
//         CustomNavigation.push(context, ScreenIndividualPage());
//       } : null,
//       child: Container(
//         decoration: BoxDecoration(
//           color: isDownloaded
//               ? Colors.white
//               : isLoading
//                   ? Colors.white.withOpacity(.5)
//                   : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isDownloaded
//                 ? Appcolors.kprimarycolor.withOpacity(.5)
//                 : isLoading
//                     ? Appcolors.kprimarycolor.withOpacity(.5)
//                     : Colors.redAccent.withOpacity(.5),
//             width: isDownloaded ? 1.2 : 1.5,
//           ),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 3,
//               spreadRadius: 1,
//             )
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               numberimage,
//               height: ResponsiveUtils.hp(10),
//               width: ResponsiveUtils.wp(20),
//               fit: BoxFit.cover,
//             ),
//             ResponsiveSizedBox.height10,
//             const LocaleText(
//               "numbers",
//               style: TextStyle(
//                 color: Appcolors.ktextColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600
//               ),
//             ),
//             if (isDownloaded) ...[
//               const SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.check_circle,
//                     color: Appcolors.kprimarycolor,
//                     size: 16,
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     'Downloaded',
//                     style: TextStyle(
//                       color: Appcolors.kprimarycolor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton(ContentDownloadState state) {
//     if (state is ContentDownloadLoading) {
//       return LoadingAnimationWidget.inkDrop(
//         color: Appcolors.kgreenlightColor,
//         size: 25
//       );
//     } else if (state is ContentDownloadSuccessState) {
//       return PopupMenuButton<String>(
//         icon: const Icon(
//           Icons.more_vert,
//           color: Appcolors.kgreenlightColor,
//           size: 30,
//         ),
//         onSelected: (value) {
//           if (value == 'redownload') {
//             _showRedownloadDialog();
//           } else if (value == 'play') {
//             CustomNavigation.push(context, ScreenIndividualPage());
//           }
//         },
//         itemBuilder: (context) => [
//           const PopupMenuItem(
//             value: 'play',
//             child: Row(
//               children: [
//                 Icon(CupertinoIcons.play_circle, color: Appcolors.kprimarycolor),
//                 SizedBox(width: 8),
//                 Text('Play'),
//               ],
//             ),
//           ),
//           const PopupMenuItem(
//             value: 'redownload',
//             child: Row(
//               children: [
//                 Icon(CupertinoIcons.refresh, color: Colors.orange),
//                 SizedBox(width: 8),
//                 Text('Redownload'),
//               ],
//             ),
//           ),
//         ],
//       );
//     } else if (state is ContentDownloadErrorState) {
//       return IconButton(
//         onPressed: () {
//           context.read<ContentDownloadBloc>().add(DownloadButtonClickEvent());
//         },
//         icon: const Icon(
//           CupertinoIcons.refresh,
//           size: 30,
//           color: Colors.red,
//         ),
//       );
//     } else {
//       return IconButton(
//         onPressed: () {
//           context.read<ContentDownloadBloc>().add(DownloadButtonClickEvent());
//         },
//         icon: const Icon(
//           CupertinoIcons.arrow_down_circle,
//           size: 30,
//           color: Appcolors.kgreenlightColor,
//         ),
//       );
//     }
//   }

//   void _showRedownloadDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Redownload Content'),
//         content: const Text(
//           'This will replace existing content with fresh data. Continue?'
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               context.read<ContentDownloadBloc>().add(RedownloadButtonClickEvent());
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Appcolors.kprimarycolor,
//             ),
//             child: const Text(
//               'Redownload',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildImageWithFallback({
//     required String imageUrl,
//     required double width,
//     required double height,
//     BoxFit fit = BoxFit.cover,
//   }) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       width: width,
//       height: height,
//       fit: fit,
//       placeholder: (context, url) => Center(
//         child: LoadingAnimationWidget.bouncingBall(
//           color: Appcolors.kwhiteColor,
//           size: ResponsiveUtils.wp(10)
//         )
//       ),
//       errorWidget: (context, url, error) => Container(
//         width: width,
//         height: height,
//         color: Colors.grey[200],
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.image_not_supported_outlined,
//               size: ResponsiveUtils.wp(10),
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Image not available',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: ResponsiveUtils.wp(3),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///////////////////////////////////
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/Content_download_bloc/content_download_bloc.dart';
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
  final bool isDownloaded;

  GridItemPainter({required this.color, required this.isDownloaded});

  @override
  void paint(Canvas canvas, Size size) {
    if (isDownloaded) {
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ignore: must_be_immutable
class ScreenHomePage extends StatefulWidget {
  ScreenHomePage({super.key});

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

    // Check download status when screen loads
    context.read<ContentDownloadBloc>().add(CheckDownloadStatusEvent());
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
                // const Color(0xFF667EEA),
                // const Color(0xFF764BA2),
                Appcolors.kprimarycolor,
                Appcolors.kgreenlightColor,
                // // Color(0xFF4CAF50),
                // // Color(0xFF66BB6A),
                // Color.fromARGB(255, 129, 199, 193),
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
                    // Color(0xFF4CAF50),
                    // Color(0xFF66BB6A),
                    // Color(0xFF81C784),
                    // const Color(0xFF667EEA),
                    // const Color(0xFF764BA2),
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
                const SizedBox(height: 20),

                // Content grid
                BlocConsumer<ContentDownloadBloc, ContentDownloadState>(
                  listener: (context, state) {
                    if (state is ContentDownloadErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Download failed: ${state.error}'),
                          backgroundColor: const Color(0xFFE57373),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          action: SnackBarAction(
                            label: 'Retry',
                            textColor: Colors.white,
                            onPressed: () {
                              context
                                  .read<ContentDownloadBloc>()
                                  .add(DownloadButtonClickEvent());
                            },
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return _buildContentGrid(state);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildContentGrid(ContentDownloadState state) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ResponsiveUtils.wp(4),
          mainAxisSpacing: ResponsiveUtils.wp(4),
          childAspectRatio: 1.0,
        ),
        shrinkWrap: true,
        itemCount: 1,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SlideTransition(
            position: _slideAnimation,
            child: _buildGridItem(state),
          );
        },
      ),
    );
  }

  Widget _buildGridItem(ContentDownloadState state) {
    //final isDownloaded = state is ContentDownloadSuccessState;
    // final isLoading = state is ContentDownloadLoading;
    // final isError = state is ContentDownloadErrorState;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildMainContainer(state),
          ),
          Positioned(
            top: ResponsiveUtils.hp(1),
            right: ResponsiveUtils.wp(2),
            child: _buildActionButton(state),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContainer(ContentDownloadState state) {
    final isDownloaded = state is ContentDownloadSuccessState;
    final isLoading = state is ContentDownloadLoading;
    final isError = state is ContentDownloadErrorState;

    // ignore: unused_local_variable
    Color containerColor;
    Color borderColor;
    List<Color> gradientColors;

    if (isDownloaded) {
      containerColor = Colors.white;
      borderColor = Appcolors.kprimarycolor;
      gradientColors = [
        const Color.fromARGB(255, 96, 219, 198).withOpacity(0.1),
        Colors.white,
      ];
    } else if (isLoading) {
      containerColor = Colors.white.withOpacity(0.9);
      borderColor = const Color(0xFF81C784);
      gradientColors = [
        const Color(0xFF81C784).withOpacity(0.1),
        Colors.white,
      ];
    } else if (isError) {
      containerColor = Colors.white;
      borderColor = const Color(0xFFE57373);
      gradientColors = [
        const Color(0xFFE57373).withOpacity(0.1),
        Colors.white,
      ];
    } else {
      containerColor = Colors.white;
      borderColor = const Color(0xFF90A4AE);
      gradientColors = [
        const Color(0xFF90A4AE).withOpacity(0.1),
        Colors.white,
      ];
    }

    return InkWell(
      onTap: isDownloaded
          ? () {
              CustomNavigation.push(context, ScreenIndividualPage());
            }
          : null,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: isDownloaded ? 2.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 6,
              spreadRadius: -2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: CustomPaint(
          painter: GridItemPainter(
            color: borderColor,
            isDownloaded: isDownloaded,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon container with enhanced styling
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: borderColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Image.asset(
                  numberimage,
                  height: ResponsiveUtils.hp(6),
                  width: ResponsiveUtils.wp(12),
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 12),

              // Title with better typography
              const LocaleText(
                "numbers",
                style: TextStyle(
                  color: Color(0xFF2E3440),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 8),

              // Status indicator
              if (isDownloaded) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Appcolors.kprimarycolor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Ready to Play',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (isLoading) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF81C784),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Downloading...',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ] else if (isError) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE57373),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Tap to Retry',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF90A4AE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Tap to Download',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(ContentDownloadState state) {
    if (state is ContentDownloadLoading) {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: const Color(0xFF4CAF50),
          size: 20,
        ),
      );
    } else if (state is ContentDownloadSuccessState) {
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: Appcolors.kprimarycolor,
            size: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) {
            if (value == 'redownload') {
              _showRedownloadDialog();
            } else if (value == 'play') {
              CustomNavigation.push(context, ScreenIndividualPage());
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'play',
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.play_circle,
                      color: Color(0xFF4CAF50),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Play',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'redownload',
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.refresh,
                      color: Colors.orange,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Redownload',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (state is ContentDownloadErrorState) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            context.read<ContentDownloadBloc>().add(DownloadButtonClickEvent());
          },
          icon: const Icon(
            CupertinoIcons.refresh,
            size: 24,
            color: Color(0xFFE57373),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4CAF50).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            context.read<ContentDownloadBloc>().add(DownloadButtonClickEvent());
          },
          icon: const Icon(
            CupertinoIcons.arrow_down_circle,
            size: 24,
            color: Color(0xFF4CAF50),
          ),
        ),
      );
    }
  }

  void _showRedownloadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.refresh,
                color: Colors.orange,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Redownload Content',
              style: GoogleFonts.fredoka(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'This will replace existing content with fresh data. Continue?',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<ContentDownloadBloc>()
                  .add(RedownloadButtonClickEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Redownload',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
