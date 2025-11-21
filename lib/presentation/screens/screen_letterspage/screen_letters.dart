import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

class Letter {
  final String letter;
  final String imageUrl;
  final String word;

  Letter({
    required this.letter,
    required this.imageUrl,
    required this.word,
  });
}

class LettersGalleryScreen extends StatelessWidget {
  LettersGalleryScreen({super.key});

  // Hardcoded list - replace with API data later
  final List<Letter> letters = [
    Letter(
      letter: 'A',
      imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445',
      word: 'Apple',
    ),
    Letter(
      letter: 'B',
      imageUrl: 'https://images.unsplash.com/photo-1587049352846-4a222e784538',
      word: 'Butterfly',
    ),
    Letter(
      letter: 'C',
      imageUrl: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba',
      word: 'Cat',
    ),
    Letter(
      letter: 'D',
      imageUrl: 'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e',
      word: 'Dog',
    ),
    Letter(
      letter: 'E',
      imageUrl: 'https://images.unsplash.com/photo-1596550515832-f8d91f34e2b9',
      word: 'Elephant',
    ),
    Letter(
      letter: 'F',
      imageUrl: 'https://images.unsplash.com/photo-1525382455947-f319bc05fb35',
      word: 'Fish',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Appcolors.kprimarycolor.withOpacity(0.1),
              Colors.white,
              Appcolors.kgreenlightColor.withOpacity(0.05),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Beautiful App Bar
            SliverAppBar(
              expandedHeight: ResponsiveUtils.hp(22),
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Appcolors.kprimarycolor,
                        Appcolors.kprimarycolor.withOpacity(0.8),
                        Appcolors.kgreenlightColor,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative circles
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Container(
                          width: ResponsiveUtils.wp(40),
                          height: ResponsiveUtils.wp(40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ResponsiveUtils.hp(8),
                        left: -30,
                        child: Container(
                          width: ResponsiveUtils.wp(25),
                          height: ResponsiveUtils.wp(25),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                      // Content
                      Positioned(
                        bottom: ResponsiveUtils.hp(4),
                        left: ResponsiveUtils.wp(6),
                        right: ResponsiveUtils.wp(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Explore Letters',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveUtils.wp(7),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            Text(
                              'Discover amazing learning letters',
                              style: TextStyle(
                                color: Appcolors.kwhiteColor.withOpacity(0.9),
                                fontSize: ResponsiveUtils.wp(4),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // App bar when collapsed
              title: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Letters',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              centerTitle: true,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            // Grid Content
            SliverPadding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: letters.length,
                  (context, index) {
                    return LetterCard(letter: letters[index]);
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: ResponsiveUtils.wp(4),
                  mainAxisSpacing: ResponsiveUtils.hp(2),
                  childAspectRatio: 0.85,
                ),
              ),
            ),
            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: ResponsiveUtils.hp(2)),
            ),
          ],
        ),
      ),
    );
  }
}

class LetterCard extends StatelessWidget {
  final Letter letter;

  const LetterCard({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap - navigate to detail or play sound
      },
      child: Container(
        decoration: BoxDecoration(
          color: Appcolors.kwhiteColor,
          borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
          boxShadow: [
            BoxShadow(
              color: Appcolors.kgreycolor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Letter badge
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: ResponsiveUtils.wp(12),
                  height: ResponsiveUtils.wp(12),
                  decoration: BoxDecoration(
                    color: Appcolors.kprimarycolor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      letter.letter,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(6),
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kwhiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Image
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(3)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
                  child: Image.network(
                    letter.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Appcolors.korangedoublelightColor,
                        child: Icon(
                          Icons.image,
                          size: ResponsiveUtils.wp(15),
                          color: Appcolors.korangeColor,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Appcolors.korangedoublelightColor,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Appcolors.kprimarycolor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Word label
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.hp(1),
                  horizontal: ResponsiveUtils.wp(2),
                ),
                decoration: BoxDecoration(
                  color: Appcolors.korangedoublelightColor,
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                ),
                child: Center(
                  child: TextStyles.body(
                    text: letter.word,
                    weight: FontWeight.w600,
                    color: Appcolors.korangeColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}