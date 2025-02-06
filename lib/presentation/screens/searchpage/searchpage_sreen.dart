import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';


import 'package:langlex/presentation/screens/searchpage/widgets/search_Idle.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

class ScreenSearchPage extends StatelessWidget {
  ScreenSearchPage({super.key});

  final List caroselimages = [
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
    'assets/images/carosel4.jpg',
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
    'assets/images/carosel4.jpg',
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
    'assets/images/carosel4.jpg',
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
    'assets/images/carosel4.jpg',
  ];
  final words = [
    'Numbers',
    'Animals',
    'Fruits',
    'Vegitables',
    'Wild Animals',
    'Numbers',
    'Animals',
    'Fruits',
    'Vegitables',
    'Wild Animals',
    'Wild Animals',
    'Numbers',
    'Animals',
    'Fruits',
    'Vegitables',
    'Wild Animals',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            snap: true,
            backgroundColor: Appcolors.kbackgroundcolor,
            elevation: 0.5,
            title: InkWell(
              onTap: () {
                navigatePush(context, SearchIdle());
              },
              child: CupertinoSearchTextField(
                enabled: false,
                backgroundColor: Appcolors.kgreenlightColor.withOpacity(0.4),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Appcolors.kgreenColor,
                ),
                style: const TextStyle(color: Appcolors.kgreenColor),
              ),
            ),
          ),
           SliverToBoxAdapter(
            child:ResponsiveSizedBox.height10,
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 5,
              childAspectRatio: .75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InkWell(
                  onTap: () {
                   
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Appcolors.korangeColor.withOpacity(.4),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            caroselimages[index],
                            height:ResponsiveUtils.hp(.09),
                            width:ResponsiveUtils.wp(.15),
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            words[index],
                            style: const TextStyle(
                                color: Appcolors.ktextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Image.asset(
                  //     caroselimages[index],
                  //     fit: BoxFit.cover,

                  //   ),
                  // ),
                );
              },
              childCount: caroselimages.length,
            ),
          ),
        ],
      ),
    )));
  }
}
