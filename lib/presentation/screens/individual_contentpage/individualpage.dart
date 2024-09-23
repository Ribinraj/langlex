import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/widgets/audio_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ScreenIndividualPage extends StatelessWidget {
  ScreenIndividualPage({super.key});
  final AudioService _audioService = AudioService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Appcolors.kgreenlightColor, // Start color (bottom)
              Appcolors.kbackgroundcolor, // End color (top)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: h(context) * .06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 IconButton(
  onPressed: () {
    Navigator.pop(context);
  },
  icon: Icon(
    CupertinoIcons.arrowshape_turn_up_left_circle_fill,
    color: Appcolors.kgreenColor,
    size: 45,
  ),
),

                  Text(
                    'Animals',
                    style: GoogleFonts.playpenSans(
                        textStyle: TextStyle(
                            color: Appcolors.kgreenColor,
                            fontWeight: FontWeight.w600,
                            fontSize: AppDimensions.fontSize25(context))),
                  ),
                  SizedBox(
                    height: 60,
                    child: CircularPercentIndicator(
                      radius: 20.0,
                      center: const Text(
                        "70%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      lineWidth: 3.0,
                      animation: true,
                      percent: 0.7,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Appcolors.kgreenColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h(context) * .04,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10), // Set the desired border radius
                  border: Border.all(
                    color: Appcolors.korangeColor.withOpacity(.7),
                    // Set the desired border color
                    width: 2, // Set the border width
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10), // Match border radius for clipping
                  child: Image.asset(
                    'assets/images/leopard.jpg',
                    fit: BoxFit.cover,
                    height: h(context) * .5,
                    width: w(context) * .8,
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(
                'Leopard',
                style: GoogleFonts.playpenSans(
                    textStyle: const TextStyle(
                        color: Appcolors.kgreenColor,
                        fontWeight: FontWeight.w600),
                    fontSize: AppDimensions.fontSize30(context)),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                height: h(context) * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/arrow previous.png',
                        fit: BoxFit.cover,
                        height: h(context) * .1,
                        //width: w(context) * .2,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _audioService.playAudioFromFile('sounds/audio.mp3');
                        print('audio');
                      },
                      child: Image.asset(
                        'assets/images/playbutton.png',
                        fit: BoxFit.cover,
                        height: h(context) * .1,
                        // width: w(context) * .1,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/arrow next.png',
                        fit: BoxFit.cover,
                        height: h(context) * .1,
                        // width: w(context) * .2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h(context) * .02,
              )
            ],
          ),
        ),
      ),
    );
  }
}
