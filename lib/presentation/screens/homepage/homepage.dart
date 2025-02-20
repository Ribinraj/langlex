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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class ScreenHomePage extends StatelessWidget {
  ScreenHomePage({super.key});
  List caroselimages = [
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
    'assets/images/carosel4.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      key: scaffoldKey,
      endDrawer: CustomDrawer(),
      // endDrawer: Drawer(
      //   child: Padding(
      //     padding: const EdgeInsets.all(10),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           height: h(context) * 0.07,
      //         ),
      //         const CustomRoundImage(
      //           circleContainerSize: 90,
      //           imageUrl:
      //               'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png',
      //         ),
      //         SizedBox(
      //           height: h(context) * 0.02,
      //         ),
      //         Text('Hii Akbar',
      //             style: TextStyle(
      //                 fontSize: AppDimensions.fontSize17(context),
      //                 fontWeight: FontWeight.w600)),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Appcolors.kgreenColor,
                Color.fromARGB(255, 75, 209, 155)
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRoundImage(
              circleContainerSize: 45,
              imageUrl:
                  'https://anakoskaphotography.com/wp-content/uploads/2018/09/outdoor-children-photo-of-a-girl.jpg',
            ),
          ],
        ),
        actions: [
          const DropdownExample(),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Appcolors.kwhiteColor,
              size: 25,
            ), // Drawer icon
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer(); // Open the end drawer
            },
          ),
          ResponsiveSizedBox.height10,
        ],
      ),
      body: ListView(
        // padding: const EdgeInsets.all(15),
        children: [
          // ResponsiveSizedBox.height10,
          Container(
              //padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.wp(4)),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.kgreenColor,
                      Color.fromARGB(255, 99, 233, 179)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/back-school-background.png', // Replace with your asset image path
                      height: ResponsiveUtils.hp(28),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: ResponsiveUtils.hp(6),
                      left: ResponsiveUtils.wp(5),
                      child: Text(
                        "Play, learn, and\ngrow together!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredoka(
                          fontSize: ResponsiveUtils.wp(5.5),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // child: CarouselSlider.builder(
              //   itemCount: caroselimages.length,
              //   options: CarouselOptions(
              //       autoPlay: true,
              //       enlargeCenterPage: true,
              //       viewportFraction: .4,
              //       pageSnapping: true,
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       autoPlayAnimationDuration: const Duration(seconds: 1)),
              //   itemBuilder: (context, itemIndex, pageViewIndex) {
              //     return Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //         border: Border.all(
              //           color: Appcolors.kgreenColor.withOpacity(.4),
              //           width: 1, // Set the border width
              //         ),
              //       ),
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(
              //             15), // Match border radius for clipping
              //         child: Image.asset(
              //           caroselimages[itemIndex],
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     );
              //   },
              // ),
              ),
          ResponsiveSizedBox.height10,
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 2,
                ),
                shrinkWrap: true,
                itemCount: 8,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BlocBuilder<ContentDownloadBloc, ContentDownloadState>(
                    builder: (context, state) {
                      if (state is ContentDownloadInitial) {
                        return Stack(
                          children: [
                            Positioned.fill(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color:
                                              Colors.redAccent.withOpacity(.5),
                                          width: 1.5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          numberimage,
                                          height: ResponsiveUtils.hp(10),
                                          width: ResponsiveUtils.wp(20),
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const LocaleText(
                                          "numbers",
                                          style: TextStyle(
                                              color: Appcolors.ktextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ))),
                            Positioned(
                              top: ResponsiveUtils.hp(2),
                              right: ResponsiveUtils.wp(2),
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<ContentDownloadBloc>()
                                        .add(DownlaodButtonClickEvent());
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.arrow_down_circle,
                                    size: 30,
                                    color: Appcolors.kgreenlightColor,
                                  )),
                            ),
                          ],
                        );
                      } else if (state is ContentDownloadLoading) {
                        return Stack(
                          children: [
                            Positioned.fill(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.5),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Appcolors.kgreenColor
                                                .withOpacity(.5),
                                            width: 1.2)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          numberimage,
                                          height: ResponsiveUtils.hp(10),
                                          width: ResponsiveUtils.wp(20),
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const LocaleText(
                                          "numbers",
                                          style: TextStyle(
                                              color: Appcolors.ktextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ))),
                            Positioned(
                              top: ResponsiveUtils.hp(2),
                              right: ResponsiveUtils.hp(2),
                              child: LoadingAnimationWidget.inkDrop(
                                  color: Appcolors.kgreenlightColor, size: 25),
                            ),
                          ],
                        );
                      } else if (state is ContentDownloadSuccessState) {
                        return Stack(
                          children: [
                            Positioned.fill(
                                child: InkWell(
                              onTap: () {
                                CustomNavigation.push(
                                    context, ScreenIndividualPage());
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Appcolors.kgreenColor
                                              .withOpacity(.5),
                                          width: 1.2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        numberimage,
                                        height: ResponsiveUtils.hp(10),
                                        width: ResponsiveUtils.wp(20),
                                        fit: BoxFit.cover,
                                      ),
                                      ResponsiveSizedBox.height10,
                                      const LocaleText(
                                        "numbers",
                                        style: TextStyle(
                                            color: Appcolors.ktextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )),
                            )),
                            Positioned(
                              top: ResponsiveUtils.hp(2),
                              right: ResponsiveUtils.wp(2),
                              child: const Icon(
                                CupertinoIcons.play_circle,
                                color: Appcolors.kgreenlightColor,
                                size: 33,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                }),
          )
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
