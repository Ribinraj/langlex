import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/blocs/Fetch_data_from_database/fetchdata_from_database_bloc.dart';
import 'package:langlex/presentation/widgets/audio_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ScreenIndividualPage extends StatefulWidget {
  ScreenIndividualPage({super.key});

  @override
  State<ScreenIndividualPage> createState() => _ScreenIndividualPageState();
}

class _ScreenIndividualPageState extends State<ScreenIndividualPage> {
  final AudioService _audioService = AudioService();

  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<FetchdataFromDatabaseBloc>()
        .add(FetchDataFromDatabaseInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchdataFromDatabaseBloc, FetchdataFromDatabaseState>(
        builder: (context, state) {
          if (state is FetchDataFromDatabaseLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Appcolors.kgreenColor, size: 40),
            );
          } else if (state is FetchDataFromDatabaseSuccessState) {
            final dataItems = state.dataItems;
            log(dataItems.length.toString());
            if (dataItems.isEmpty) {
              return Center(
                child: Text('No items To display'),
              );
            }
            final item = dataItems[currentIndex];
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: .15,
                  image: AssetImage(
                      profilebackgroundimage), // Correct way to use asset image
                  fit: BoxFit.cover,
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
                            center: Text(
                              "${((currentIndex + 1) / dataItems.length * 100).toInt()}%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            lineWidth: 3.0,
                            animation: true,
                            percent: (currentIndex + 1) / dataItems.length,
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
                          color: Appcolors.kgreenColor.withOpacity(.7),
                          // Set the desired border color
                          width: 2, // Set the border width
                        ),
                      ),
                      // child: Container(
                      //   height: 200,
                      //   width: 200,
                      //   child: Image.file(File(
                      //       '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}')),
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), 
                        child: Image.file(
                          File(
                              '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.img}'),
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
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: currentIndex > 0
                                  ? () {
                                      setState(() {
                                        currentIndex--;
                                      });
                                      _audioService.stopAudio();
                                    }
                                  : null,
                              icon: Icon(
                                CupertinoIcons
                                    .arrowshape_turn_up_left_circle_fill,
                                color: Appcolors.kgreenColor,
                                size: 55,
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Image.asset(
                            //     'assets/images/arrow previous.png',
                            //     fit: BoxFit.cover,
                            //     height: h(context) * .1,
                            //     //width: w(context) * .2,
                            //   ),
                            // ),
                            // InkWell(
                            //   onTap: () {
                            //     _audioService.playAudioFromFile('sounds/audio.mp3');
                            //     print('audio');
                            //   },
                            //   child: Image.asset(
                            //     'assets/images/playbutton.png',
                            //     fit: BoxFit.cover,
                            //     height: h(context) * .1,
                            //     // width: w(context) * .1,
                            //   ),
                            // ),
                            IconButton(
                              onPressed: () {
                                _audioService.playAudioFromFile(
                                    '/data/user/0/com.example.langlex/app_flutter/extracted/file/${item.mp3}');
                              },
                              icon: Icon(
                                CupertinoIcons.play_circle_fill,
                                color: Appcolors.kgreenColor,
                                size: 55,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _audioService.pauseAudio();
                              },
                              icon: Icon(
                                CupertinoIcons.pause_circle_fill,
                                color: Appcolors.kgreenColor,
                                size: 55,
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Image.asset(
                            //     'assets/images/arrow next.png',
                            //     fit: BoxFit.cover,
                            //     height: h(context) * .1,
                            //     // width: w(context) * .2,
                            //   ),
                            // ),
                            IconButton(
                              onPressed: currentIndex < dataItems.length - 1
                                  ? () {
                                      setState(() {
                                        currentIndex++;
                                      });
                                      _audioService.stopAudio();
                                    }
                                  : null,
                              icon: Icon(
                                CupertinoIcons
                                    .arrowshape_turn_up_right_circle_fill,
                                color: Appcolors.kgreenColor,
                                size: 55,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Item ${currentIndex + 1} of ${dataItems.length}'),
                    SizedBox(
                      height: h(context) * .06,
                    )
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
