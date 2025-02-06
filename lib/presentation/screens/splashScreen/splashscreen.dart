import 'dart:async';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/screens/loginpage/loginpage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the next screen after a delay
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ScreenLoginpage()),
      );
// Replace with your home route
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set background color if needed
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo, // Replace with your asset image path
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
                fit: BoxFit.contain, // Adjust to fit the image properly
              ),
            ResponsiveSizedBox.height5,
              LoadingAnimationWidget.staggeredDotsWave(
                  color: Appcolors.kgreenColor, size: 40)
            ],
          ),
        ),
      ),
    );
  }
}
