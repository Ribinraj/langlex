import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

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
                      horizontal: 8.0,
                      vertical: 3,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: h(context) * 0.13,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: AppDimensions.kradius10,
                          border: Border.all(
                            color: Appcolors.korangeColor.withOpacity(.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Set the desired border radius
                                border: Border.all(
                                  color: Appcolors.korangeColor.withOpacity(
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
                                  //height: h(context) * .095,
                                  width: w(context) * .4,
                                ),
                              ),
                            ),
                            // Image.asset(
                            //   caroselimages[index],
                            //   height: h(context) * .09,
                            //   width: w(context) * .4,
                            //   fit: BoxFit.cover,
                            // ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              words[index],
                              style: const TextStyle(
                                  color: Appcolors.ktextColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            )
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
