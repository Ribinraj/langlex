// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';
// import 'package:langlex/core/responsive_utils.dart';

// import 'package:langlex/presentation/screens/searchpage/widgets/search_Idle.dart';
// import 'package:langlex/presentation/widgets/custom_navigation.dart';

// class ScreenSearchPage extends StatelessWidget {
//   ScreenSearchPage({super.key});

//   final List caroselimages = [
//     'assets/images/carosel1.jpg',
//     'assets/images/carosel2.jpg',
//     'assets/images/carosel3.jpg',
//     'assets/images/carosel4.jpg',
//     'assets/images/carosel1.jpg',
//     'assets/images/carosel2.jpg',
//     'assets/images/carosel3.jpg',
//     'assets/images/carosel4.jpg',
//     'assets/images/carosel1.jpg',
//     'assets/images/carosel2.jpg',
//     'assets/images/carosel3.jpg',
//     'assets/images/carosel4.jpg',
//     'assets/images/carosel1.jpg',
//     'assets/images/carosel2.jpg',
//     'assets/images/carosel3.jpg',
//     'assets/images/carosel4.jpg',
//   ];
//   final words = [
//     'Numbers',
//     'Animals',
//     'Fruits',
//     'Vegitables',
//     'Wild Animals',
//     'Numbers',
//     'Animals',
//     'Fruits',
//     'Vegitables',
//     'Wild Animals',
//     'Wild Animals',
//     'Numbers',
//     'Animals',
//     'Fruits',
//     'Vegitables',
//     'Wild Animals',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             floating: true,
//             automaticallyImplyLeading: false,
//             snap: true,
//             backgroundColor: Appcolors.kbackgroundcolor,
//             elevation: 0.5,
//             title: InkWell(
//               onTap: () {
//                 CustomNavigation.push(context, SearchIdle());
//               },
//               child: CupertinoSearchTextField(
//                 enabled: false,
//                 backgroundColor: Appcolors.kgreenlightColor.withOpacity(0.4),
//                 prefixIcon: const Icon(
//                   CupertinoIcons.search,
//                   color: Appcolors.kprimarycolor,
//                 ),
//                 style: const TextStyle(color: Appcolors.kprimarycolor),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: ResponsiveSizedBox.height10,
//           ),
//           SliverGrid(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 6,
//               mainAxisSpacing: 6,
//               childAspectRatio: .75,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return InkWell(
//                   onTap: () {},
//                   child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(.8),
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             width: 1,
//                             color: Appcolors.kborderColor,
//                           )),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             caroselimages[index],
//                             height: ResponsiveUtils.hp(12),
//                             width: ResponsiveUtils.wp(25),
//                             fit: BoxFit.cover,
//                           ),
//                           ResponsiveSizedBox.height10,
//                           TextStyles.medium(
//                               text: words[index],
//                               color: Appcolors.ktextColor,
//                               weight: FontWeight.w600)
//                         ],
//                       )),
//                   // child: ClipRRect(
//                   //   borderRadius: BorderRadius.circular(10),
//                   //   child: Image.asset(
//                   //     caroselimages[index],
//                   //     fit: BoxFit.cover,

//                   //   ),
//                   // ),
//                 );
//               },
//               childCount: caroselimages.length,
//             ),
//           ),
//         ],
//       ),
//     )));
//   }
// }
/////////////////////////////////////////
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

import 'package:langlex/presentation/screens/searchpage/widgets/search_Idle.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

class ScreenSearchPage extends StatefulWidget {
  const ScreenSearchPage({super.key});

  @override
  State<ScreenSearchPage> createState() => _ScreenSearchPageState();
}

class _ScreenSearchPageState extends State<ScreenSearchPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    'Vegetables',
    'Wild Animals',
    'Numbers',
    'Animals',
    'Fruits',
    'Vegetables',
    'Wild Animals',
    'Wild Animals',
    'Numbers',
    'Animals',
    'Fruits',
    'Vegetables',
    'Wild Animals',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: Container(
        color: const Color(0xFFF8FBFF),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Enhanced App Bar
                SliverAppBar(
                  foregroundColor: const Color(0xFFF8FBFF),
                  floating: true,
                  automaticallyImplyLeading: false,
                  snap: true,
                  backgroundColor: const Color(0xFFF8FBFF),
                  elevation: 0,
                  expandedHeight: 80,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FBFF),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: _buildSearchBar(),
                      ),
                    ),
                  ),
                ),

                // Spacing
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ResponsiveSizedBox.height10,
                      // Add a subtle title section
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Appcolors.kprimarycolor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 12),
                              TextStyles.medium(
                                text: "Explore Categories",
                                color: Appcolors.ktextColor,
                                weight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Enhanced Grid
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              (index * 0.1).clamp(0.0, 1.0),
                              ((index * 0.1) + 0.3).clamp(0.0, 1.0),
                              curve: Curves.easeOutBack,
                            ),
                          )),
                          child: _buildCategoryCard(index),
                        ),
                      );
                    },
                    childCount: caroselimages.length,
                  ),
                ),

                // Bottom spacing
                SliverToBoxAdapter(
                  child: SizedBox(height: ResponsiveUtils.hp(2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return InkWell(
      onTap: () {
        CustomNavigation.push(context, const SearchIdle());
      },
      borderRadius: BorderRadius.circular(5),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: CupertinoSearchTextField(
          enabled: false,
          backgroundColor: Appcolors.kgreenlightColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
          prefixIcon: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              CupertinoIcons.search,
              color: Appcolors.kprimarycolor,
              size: 20,
            ),
          ),
          suffixIcon: Icon(
            CupertinoIcons.mic,
            color: Appcolors.kprimarycolor.withOpacity(0.6),
            size: 18,
          ),
          style: const TextStyle(
            color: Appcolors.kprimarycolor,
            fontSize: 16,
          ),
          placeholder: "Search categories...",
          placeholderStyle: TextStyle(
            color: Appcolors.kprimarycolor.withOpacity(0.6),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(int index) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.95),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1.5,
            color: Appcolors.kborderColor.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Appcolors.kprimarycolor.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image Container with enhanced styling
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Appcolors.kprimarycolor.withOpacity(0.1),
                        Colors.transparent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Image.asset(
                    caroselimages[index],
                    height: ResponsiveUtils.hp(10),
                    width: ResponsiveUtils.wp(22),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: ResponsiveUtils.hp(1.2)),

            // Enhanced Text with better spacing
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextStyles.medium(
                text: words[index],
                color: Appcolors.ktextColor,
                weight: FontWeight.w600,
              ),
            ),

            // Subtle accent line
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 2,
              width: 20,
              decoration: BoxDecoration(
                color: Appcolors.kprimarycolor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
