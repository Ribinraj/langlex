import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

class SearchIdle extends StatefulWidget {
  const SearchIdle({super.key});

  @override
  State<SearchIdle> createState() => _SearchIdleState();
}

class _SearchIdleState extends State<SearchIdle> {
  final TextEditingController searchcontroller = TextEditingController();
  final List caroselimages = [
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
    'assets/images/carosel4.jpg',
    'assets/images/carosel1.jpg',
    'assets/images/carosel2.jpg',
    'assets/images/carosel3.jpg',
  ];
  final words = [
    'Numbers',
    'Animals',
    'Fruits',
    'Vegitables',
    'Wild Animals',
    'Numbers',
    'Animals',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Appcolors.kgreenColor,
                ),
              ),
              title: CupertinoSearchTextField(
                controller: searchcontroller,
                backgroundColor: Appcolors.kgreenlightColor.withOpacity(0.4),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Appcolors.kgreenColor,
                ),
                suffixIcon: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Appcolors.kgreenlightColor,
                ),
                style: const TextStyle(color: Appcolors.ktextColor),
                onChanged: (value) {},
              ),
              backgroundColor: Appcolors.kbackgroundcolor,
            ),
            // Add space below the search bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 16), // Adjust height as needed
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: ResponsiveUtils.hp(10),
                        padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                        decoration: BoxDecoration(
                          color: Appcolors.kwhiteColor,
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Appcolors.kgreenColor.withOpacity(.1),
                          //     Appcolors.kwhiteColor
                          //   ],
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          // ),
                          borderRadius: BorderRadiusStyles.kradius10(),
                          border: Border.all(
                              color: Appcolors.kgreenColor.withOpacity(.4),
                              width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Set the desired border radius
                                border: Border.all(
                                  color: Appcolors.kgreenColor.withOpacity(
                                      .4), // Set the desired border color
                                  width: 1, // Set the border width
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10), // Match border radius for clipping
                                child: Image.asset(
                                  caroselimages[index],
                                  fit: BoxFit.cover,
                                  // height: ResponsiveUtils.hp(17),
                                  width: ResponsiveUtils.wp(25),
                                ),
                              ),
                            ),
                            // Image.asset(
                            //   caroselimages[index],
                            //   height: h(context) * .09,
                            //   width: w(context) * .4,
                            //   fit: BoxFit.cover,
                            // ),
                            ResponsiveSizedBox.width20,
                            TextStyles.body(
                                text: words[index],
                                color: Appcolors.ktextColor,
                                weight: FontWeight.bold)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: caroselimages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
