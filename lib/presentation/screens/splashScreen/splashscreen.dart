// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:langlex/core/colors.dart';
// // import 'package:langlex/core/constants.dart';
// // import 'package:langlex/presentation/screens/loginpage/loginpage.dart';
// // import 'package:loading_animation_widget/loading_animation_widget.dart';

// // class SplashPage extends StatelessWidget {
// //   const SplashPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Navigate to the next screen after a delay
// //     Timer(const Duration(seconds: 3), () {
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => const ScreenLoginpage()),
// //       );
// // // Replace with your home route
// //     });

// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.white, // Set background color if needed
// //         ),
// //         child: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Image.asset(
// //                 logo, // Replace with your asset image path
// //                 width: 200, // Adjust width as needed
// //                 height: 200, // Adjust height as needed
// //                 fit: BoxFit.contain, // Adjust to fit the image properly
// //               ),
// //             ResponsiveSizedBox.height5,
// //               LoadingAnimationWidget.staggeredDotsWave(
// //                   color: Appcolors.kprimarycolor, size: 40)
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';

// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _backgroundController;
//   late AnimationController _textController;

//   late Animation<double> _logoScaleAnimation;
//   late Animation<double> _logoOpacityAnimation;
//   late Animation<double> _backgroundAnimation;
//   late Animation<double> _textFadeAnimation;
//   late Animation<Offset> _textSlideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controllers
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     _backgroundController = AnimationController(
//       duration: const Duration(milliseconds: 3000),
//       vsync: this,
//     );

//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     // Setup animations
//     _setupAnimations();

//     // Start animations
//     _startAnimations();

//     // Navigate after delay
//     // Timer(const Duration(seconds: 4), () {
//     //   Navigator.of(context).pushReplacement(
//     //     MaterialPageRoute(builder: (context) => const ScreenLoginpage()),
//     //   );
//     // });
//   }

//   void _setupAnimations() {
//     // Logo animations
//     _logoScaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
//     ));

//     _logoOpacityAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
//     ));

//     // Background animation
//     _backgroundAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _backgroundController,
//       curve: Curves.easeInOut,
//     ));

//     // Text animations
//     _textFadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
//     ));

//     _textSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
//     ));
//   }

//   void _startAnimations() {
//     _backgroundController.forward();

//     Timer(const Duration(milliseconds: 500), () {
//       _logoController.forward();
//     });

//     Timer(const Duration(milliseconds: 1200), () {
//       _textController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _backgroundController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedBuilder(
//         animation: Listenable.merge([
//           _backgroundController,
//           _logoController,
//           _textController,
//         ]),
//         builder: (context, child) {
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color.lerp(
//                     const Color.fromARGB(255, 38, 215, 132),
//                     const Color.fromARGB(255, 15, 138, 62).withOpacity(0.1),
//                     _backgroundAnimation.value,
//                   )!,
//                   Color.lerp(
//                     const Color.fromARGB(255, 47, 200, 118),
//                     const Color.fromARGB(255, 5, 72, 35).withOpacity(0.05),
//                     _backgroundAnimation.value,
//                   )!,
//                   const Color.fromARGB(255, 6, 94, 57),
//                 ],
//                 stops: const [0.0, 0.5, 1.0],
//               ),
//             ),
//             child: Stack(
//               children: [
//                 // Static decorative elements (no animation to avoid errors)
//                 Positioned(
//                   top: 100,
//                   right: 50,
//                   child: Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       color: Appcolors.kprimarycolor.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 80,
//                   left: 20,
//                   child: Container(
//                     width: 15,
//                     height: 15,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 136, 196, 180)
//                           .withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(7.5),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 200,
//                   left: 30,
//                   child: Container(
//                     width: 15,
//                     height: 15,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 171, 209, 198)
//                           .withOpacity(0.8),
//                       borderRadius: BorderRadius.circular(7.5),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 150,
//                   right: 80,
//                   child: Container(
//                     width: 18,
//                     height: 18,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 240, 247, 245)
//                           .withOpacity(0.18),
//                       borderRadius: BorderRadius.circular(9),
//                     ),
//                   ),
//                 ),

//                 // Main content
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Animated logo container
//                       Container(
//                         width: 200,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(125),
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color.fromARGB(255, 80, 147, 110)
//                                   .withOpacity(
//                                 0.3 * _logoOpacityAnimation.value,
//                               ),
//                               blurRadius: 30 * _logoOpacityAnimation.value,
//                               spreadRadius: 5 * _logoOpacityAnimation.value,
//                             ),
//                           ],
//                         ),
//                         child: Transform.scale(
//                           scale: _logoScaleAnimation.value,
//                           child: Opacity(
//                             opacity: _logoOpacityAnimation.value,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(125),
//                                 gradient: RadialGradient(
//                                   colors: [
//                                     const Color.fromARGB(255, 255, 255, 255),
//                                     Colors.white.withOpacity(0.9),
//                                     Colors.white.withOpacity(0.7),
//                                   ],
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(30),
//                                 child: Image.asset(
//                                   logo,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 40),

//                       // Animated app name/tagline
//                       SlideTransition(
//                         position: _textSlideAnimation,
//                         child: FadeTransition(
//                           opacity: _textFadeAnimation,
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 8),
//                               Text(
//                                 'Your Language Learning Journey',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey[600],
//                                   fontWeight: FontWeight.w300,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 50),

//                       // Loading animation
//                       FadeTransition(
//                         opacity: _textFadeAnimation,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             LoadingAnimationWidget.staggeredDotsWave(
//                               color: const Color.fromARGB(255, 251, 253, 252),
//                               size: 40,
//                             ),
//                             const SizedBox(width: 15),
//                             Text(
//                               'Loading...',
//                               style: TextStyle(
//                                 color: const Color.fromARGB(255, 253, 254, 254),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/screens/homepage/homepage.dart';
import 'package:langlex/presentation/screens/loginpage/loginpage.dart';
import 'package:langlex/presentation/screens/screen_student_registration/screen_registrationpage.dart';
import 'package:langlex/presentation/screens/screen_userpage/screen_userpage.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_sharedpreferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _backgroundController;
  late AnimationController _textController;
  late AnimationController _shapesController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _shapesAnimation;
  @override
void initState() {
  super.initState();

  // Initialize controllers
  _logoController = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  );

  _backgroundController = AnimationController(
    duration: const Duration(milliseconds: 3000),
    vsync: this,
  );

  _textController = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );

  _shapesController = AnimationController(
    duration: const Duration(milliseconds: 2500),
    vsync: this,
  );

  // Setup animations
  _setupAnimations();

  // Start animations
  _startAnimations();

  // Wait for final animation to finish
  _textController.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      checkUserlogin(context);
    }
  });
}


//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controllers
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     _backgroundController = AnimationController(
//       duration: const Duration(milliseconds: 3000),
//       vsync: this,
//     );

//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _shapesController = AnimationController(
//       duration: const Duration(milliseconds: 2500),
//       vsync: this,
//     );

//     // Setup animations
//     _setupAnimations();

//     // Start animations
//     _startAnimations();

//     // Navigate after delay
// checkUserlogin(context);
//   }

  void _setupAnimations() {
    // Logo animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    ));

    // Background animation
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    // Text animations
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
    ));

    // Shapes animation
    _shapesAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shapesController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    _backgroundController.forward();

    Timer(const Duration(milliseconds: 300), () {
      _shapesController.forward();
    });

    Timer(const Duration(milliseconds: 500), () {
      _logoController.forward();
    });

    Timer(const Duration(milliseconds: 1200), () {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _backgroundController.dispose();
    _textController.dispose();
    _shapesController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedShape({
    required double top,
    required double left,
    required double size,
    required Color color,
    required double delay,
    ShapeType shape = ShapeType.circle,
  }) {
    return AnimatedBuilder(
      animation: _shapesController,
      builder: (context, child) {
        final animationValue = Curves.elasticOut.transform(
            math.max(0, (_shapesAnimation.value - delay).clamp(1, 2)));

        return Positioned(
          top: top,
          left: left,
          child: Transform.scale(
            scale: animationValue,
            child: Opacity(
              opacity: animationValue,
              child: _buildShape(size, color, shape),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShape(double size, Color color, ShapeType shape) {
    switch (shape) {
      case ShapeType.circle:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size / 2),
          ),
        );
      case ShapeType.square:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
        );
      case ShapeType.triangle:
        return CustomPaint(
          size: Size(size, size),
          painter: TrianglePainter(color),
        );
      case ShapeType.diamond:
        return Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(size * 0.1),
            ),
          ),
        );
      case ShapeType.hexagon:
        return CustomPaint(
          size: Size(size, size),
          painter: HexagonPainter(color),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _backgroundController,
          _logoController,
          _textController,
        ]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Using your color palette for better gradient
                  Color.lerp(
                    Appcolors.kgreenlightColor.withOpacity(0.8),
                    Appcolors.kprimarycolor.withOpacity(0.9),
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    Appcolors.kprimarycolor,
                    Appcolors.kprimarycolor.withOpacity(0.7),
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    Appcolors.kprimarycolor.withOpacity(0.8),
                    Appcolors.ktextColor.withOpacity(0.3),
                    _backgroundAnimation.value,
                  )!,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated geometric shapes
                _buildAnimatedShape(
                  top: screenHeight * 0.1,
                  left: screenWidth * 0.8,
                  size: 15,
                  color: Appcolors.korangeColor.withOpacity(0.6),
                  delay: 0.0,
                  shape: ShapeType.circle,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.15,
                  left: screenWidth * 0.1,
                  size: 10,
                  color: Appcolors.kgreenlightColor.withOpacity(0.7),
                  delay: 0.1,
                  shape: ShapeType.square,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.15,
                  left: screenWidth * 0.55,
                  size: 15,
                  color: Appcolors.korangeColor.withOpacity(0.5),
                  delay: 0.2,
                  shape: ShapeType.triangle,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.25,
                  left: screenWidth * 0.05,
                  size: 15,
                  color: Appcolors.korangeColor.withOpacity(0.5),
                  delay: 0.2,
                  shape: ShapeType.triangle,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.7,
                  left: screenWidth * 0.1,
                  size: 12,
                  color: Colors.white.withOpacity(0.6),
                  delay: 0.3,
                  shape: ShapeType.diamond,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.75,
                  left: screenWidth * 0.85,
                  size: 18,
                  color: Appcolors.kgreenlightColor.withOpacity(0.4),
                  delay: 0.4,
                  shape: ShapeType.hexagon,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.3,
                  left: screenWidth * 0.9,
                  size: 16,
                  color:
                      const Color.fromARGB(255, 212, 229, 243).withOpacity(0.8),
                  delay: 0.5,
                  shape: ShapeType.circle,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.61,
                  left: screenWidth * 0.75,
                  size: 14,
                  color: Appcolors.korangeColor.withOpacity(0.4),
                  delay: 0.6,
                  shape: ShapeType.square,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.85,
                  left: screenWidth * 0.45,
                  size: 16,
                  color: Colors.white.withOpacity(0.5),
                  delay: 0.7,
                  shape: ShapeType.diamond,
                ),
                _buildAnimatedShape(
                  top: screenHeight * 0.45,
                  left: screenWidth * 0.09,
                  size: 16,
                  color:
                      const Color.fromARGB(255, 244, 202, 202).withOpacity(0.5),
                  delay: 0.7,
                  shape: ShapeType.diamond,
                ),
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated logo container
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(125),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolors.korangeColor.withOpacity(
                                0.3 * _logoOpacityAnimation.value,
                              ),
                              blurRadius: 30 * _logoOpacityAnimation.value,
                              spreadRadius: 5 * _logoOpacityAnimation.value,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(
                                0.2 * _logoOpacityAnimation.value,
                              ),
                              blurRadius: 20 * _logoOpacityAnimation.value,
                              spreadRadius: 2 * _logoOpacityAnimation.value,
                            ),
                          ],
                        ),
                        child: Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: Opacity(
                            opacity: _logoOpacityAnimation.value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(125),
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.95),
                                    Colors.white.withOpacity(0.8),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Image.asset(
                                  logo,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Animated app name/tagline
                      SlideTransition(
                        position: _textSlideAnimation,
                        child: FadeTransition(
                          opacity: _textFadeAnimation,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                'Your Language Learning Journey',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Loading animation
                      FadeTransition(
                        opacity: _textFadeAnimation,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'Loading...',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
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
          );
        },
      ),
    );
  }
    Future<void> checkUserlogin(context) async {
    final String usertoken = await getUserToken();
    if (usertoken.isEmpty) {
      await Future.delayed(const Duration(seconds: 5));
      CustomNavigation.pushReplaceWithTransition(context, ScreenLoginpage());
    } else {
      CustomNavigation.pushReplaceWithTransition(context, ScreenHomePage());
    }
  }
}

enum ShapeType {
  circle,
  square,
  triangle,
  diamond,
  hexagon,
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi) / 3;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
