import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
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
        backgroundColor: Appcolors.kgreenlightColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 60,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRoundImage(
              circleContainerSize: 45,
              imageUrl:
                  'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png',
            ),
          ],
        ),
        actions: [
          DropdownExample(),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .15,
            image: AssetImage(
                profilebackgroundimage), // Correct way to use asset image
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
          ResponsiveSizedBox.height10,
            CarouselSlider.builder(
              itemCount: caroselimages.length,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: .4,
                  pageSnapping: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(seconds: 1)),
              itemBuilder: (context, itemIndex, pageViewIndex) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        15), // Set the desired border radius
                    border: Border.all(
                      color: Appcolors.kgreenColor
                          .withOpacity(.4), // Set the desired border color
                      width: 1, // Set the border width
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15), // Match border radius for clipping
                    child: Image.asset(
                      caroselimages[itemIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ResponsiveSizedBox.height10,
            Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 2 / 2,
                  ),
                  shrinkWrap: true,
                  itemCount: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlocBuilder<ContentDownloadBloc,
                        ContentDownloadState>(
                      builder: (context, state) {
                        if (state is ContentDownloadInitial) {
                          return Stack(
                            children: [
                              Positioned.fill(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.5),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                            height: ResponsiveUtils.hp(2),
                                            width:ResponsiveUtils.wp(2),
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
                                right:ResponsiveUtils.wp(2),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                            height: ResponsiveUtils.hp(2),
                                            width:ResponsiveUtils.wp(2),
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
                                    color: Appcolors.kgreenlightColor,
                                    size: 25),
                              ),
                            ],
                          );
                        } else if (state is ContentDownloadSuccessState) {
                          return Stack(
                            children: [
                              Positioned.fill(
                                  child: InkWell(
                                onTap: () {
                                   navigatePush(context,  ScreenIndividualPage());
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          numberimage,
                                          height:ResponsiveUtils.hp(2),
                                          width:ResponsiveUtils.wp(2),
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
                                    )),
                              )),
                              Positioned(
                                top: ResponsiveUtils.hp(2),
                                right:ResponsiveUtils.wp(2),
                                child: Icon(
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
      ),
    );
  }
}
