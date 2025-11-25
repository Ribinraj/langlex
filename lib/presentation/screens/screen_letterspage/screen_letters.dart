import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/alphabet_model.dart';
import 'package:langlex/presentation/blocs/alphabets_bloc/alphabets_bloc.dart';
import 'package:langlex/presentation/screens/screen_letters_detailspage/sreen_lettersdetailpage.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

class AlphabetsScreen extends StatefulWidget {
  final int languageId;
  const AlphabetsScreen({super.key, required this.languageId});

  @override
  State<AlphabetsScreen> createState() => _AlphabetsScreenState();
}

class _AlphabetsScreenState extends State<AlphabetsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlphabetsBloc>().add(
          AlphabetsBlocFetchingInitialEvent(languagId: widget.languageId),
        );
  }

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
        child: BlocBuilder<AlphabetsBloc, AlphabetsState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                // Beautiful App Bar
                _buildAppBar(context),
                
                // Content based on state
                if (state is AlphabetsBlocLoadingState)
                  _buildLoadingState()
                else if (state is AlphabetBlocErrorState)
                  _buildErrorState(state.message)
                else if (state is AlphabetsBlocSuccessState)
                  _buildSuccessState(state.alphabets)
                else
                  _buildEmptyState(),
                
                // Bottom spacing
                SliverToBoxAdapter(
                  child: SizedBox(height: ResponsiveUtils.hp(2)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }

  Widget _buildLoadingState() {
           return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: SpinKitFoldingCube(
                        size: 50,
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                  );
  }

  Widget _buildErrorState(String message) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: ResponsiveUtils.wp(20),
                color: Colors.red.withOpacity(0.5),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(5),
                  fontWeight: FontWeight.bold,
                  color: Appcolors.kgreycolor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Text(
                message,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(3.5),
                  color: Appcolors.kgreycolor.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUtils.hp(3)),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<AlphabetsBloc>().add(
                        AlphabetsBlocFetchingInitialEvent(
                          languagId: widget.languageId,
                        ),
                      );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.kprimarycolor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(8),
                    vertical: ResponsiveUtils.hp(1.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: ResponsiveUtils.wp(20),
              color: Appcolors.kgreycolor.withOpacity(0.5),
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            Text(
              'No alphabets found',
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(5),
                fontWeight: FontWeight.bold,
                color: Appcolors.kgreycolor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(List<AlphabetModel> alphabets) {
    if (alphabets.isEmpty) {
      return _buildEmptyState();
    }

    return SliverPadding(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: alphabets.length,
          (context, index) {
            return LetterCard(alphabet: alphabets[index]);
          },
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ResponsiveUtils.wp(4),
          mainAxisSpacing: ResponsiveUtils.hp(2),
          childAspectRatio: 0.85,
        ),
      ),
    );
  }
}

class LetterCard extends StatelessWidget {
  final AlphabetModel alphabet;

  const LetterCard({super.key, required this.alphabet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
    CustomNavigation.pushWithTransition(context,  ScreenAlphabetDetailsPage(
        alphabet: alphabet.alphabet,
        categoryName: 'Alphabets',
      ),);
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
                      alphabet.alphabet,
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
                    '${Endpoints.imagebaseUrl}${alphabet.picture}',
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
                    text: alphabet.illWord,
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