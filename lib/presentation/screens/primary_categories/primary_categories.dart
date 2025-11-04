import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/presentation/blocs/fetch_primarycategory_bloc.dart/fetch_primarycategory_bloc.dart';

import 'package:langlex/presentation/screens/primary_categories/widgets/networkimage_categorycontainer.dart';
import 'package:langlex/presentation/screens/secondary_categories/secondary_categorypge.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

class PrimaryCategoriesPage extends StatefulWidget {
  final String heading;

  final int languageId;
  const PrimaryCategoriesPage({super.key, required this.heading, required this.languageId});

  @override
  State<PrimaryCategoriesPage> createState() => _PrimaryCategoriesPageState();
}

class _PrimaryCategoriesPageState extends State<PrimaryCategoriesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     context.read<FetchPrimarycategoryBloc>().add(
                                      FetchPrimaryCategoryInitialEvent(
                                          category: widget.heading,
                                          languageId:widget. languageId));
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
                              'Explore ${widget.heading}',
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
                              'Discover amazing learning ${widget.heading}',
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
                child: Text(
                  widget.heading,
                  style: const TextStyle(
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
            BlocBuilder<FetchPrimarycategoryBloc, FetchPrimarycategoryState>(
              builder: (context, state) {
                if (state is FetchPrimarycategoryLoadingState) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: SpinKitFoldingCube(
                        size: 50,
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                  );
                } else if (state is FetchPrimaryCategoryErrorState) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.red.shade400,
                          ),
                          SizedBox(height: ResponsiveUtils.hp(2)),
                          Text(
                            'Something went wrong!',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.wp(5),
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade400,
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.hp(1)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(10),
                            ),
                            child: Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(3.5),
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is FetchPrimarycategorySuccessState) {
                  return SliverPadding(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.primaryCategories.length,
                        (context, index) {
                          final category = state.primaryCategories[index];
                          return NetworkimageCategorycontainer(
                            title: category.categoryName,
                              imageUrl: '${Endpoints.imagebaseUrl}/${category.categoryPicture}',
                            onTap: () {
                              CustomNavigation.pushWithTransition(context,  SecondaryCategoriesPage(
      heading: category.categoryName,
      primaryCategoryId:category.primaryCategoryId,
      languageId: widget.languageId,
      parentCategory: widget.heading,
    ),);
                            },
                          );
                        },
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveUtils.wp(100) > 600 ? 3 : 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: ResponsiveUtils.wp(3),
                        mainAxisSpacing: ResponsiveUtils.hp(2),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
              },
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
