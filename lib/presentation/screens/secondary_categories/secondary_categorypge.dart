
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/responsive_utils.dart';
// import 'package:langlex/core/urls.dart';
// import 'package:langlex/domain/repository/app_repo.dart';
// import 'package:langlex/presentation/blocs/knowledge_bloc/knowledge_bloc.dart';
// import 'package:langlex/presentation/blocs/fetch_secondary_category_bloc/fetch_secondarycategory_bloc.dart';

// import 'package:langlex/presentation/screens/individual_contentpage/individualpage.dart';
// import 'package:langlex/presentation/screens/primary_categories/widgets/networkimage_categorycontainer.dart';

// import 'dart:developer';

// import 'package:langlex/presentation/screens/secondary_categories/widgets/networkimage_category_container.dart';

// class SecondaryCategoriesPage extends StatefulWidget {
//   final String heading;
//   final int primaryCategoryId;
//   final int languageId;
//   final String parentCategory;
  
//   const SecondaryCategoriesPage({
//     super.key,
//     required this.heading,
//     required this.primaryCategoryId,
//     required this.languageId,
//     required this.parentCategory,
//   });

//   @override
//   State<SecondaryCategoriesPage> createState() => _SecondaryCategoriesPageState();
// }

// class _SecondaryCategoriesPageState extends State<SecondaryCategoriesPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<FetchSecondarycategoryBloc>().add(
//           FetchsecondaryCategoryButtonClickEvent(
//             category: widget.parentCategory,
//             primaryCategoryId: widget.primaryCategoryId,
//             languageId: widget.languageId,
//           ),
//         );
//   }
// void _handleCategoryTap(int secondaryCategoryId, String categoryName) {
//   log('=== CATEGORY TAPPED ===');
//   log('Category: $categoryName');
//   log('Secondary Category ID: $secondaryCategoryId');

//   // Show loading dialog
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (dialogContext) => BlocProvider.value(
//       value: context.read<KnowledgeBloc>(),
//       child: BlocConsumer<KnowledgeBloc, KnowledgeState>(
//         listener: (context, state) {
//           if (state is KnowledgeSuccessState) {
//             log('Knowledge loaded successfully');
//             Navigator.of(dialogContext).pop(); // Close dialog
            
//             // Navigate to individual page with content
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ScreenIndividualPage(
//                   contents: state.contents,
//                   categoryName: categoryName,
//                 ),
//               ),
//             );

//             // Show snackbar if loaded from cache with re-download option
//             if (state.isFromCache) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: const Text('Loaded from local storage'),
//                   backgroundColor: Appcolors.kgreenlightColor,
//                   duration: const Duration(seconds: 4),
//                   action: SnackBarAction(
//                     label: 'Re-download',
//                     textColor: Colors.white,
//                     onPressed: () {
//                       _showRedownloadConfirmation(
//                         secondaryCategoryId,
//                         categoryName,
//                       );
//                     },
//                   ),
//                 ),
//               );
//             }
//           } else if (state is KnowledgeFailureState) {
//             log('Knowledge download/load failed');
//             Navigator.of(dialogContext).pop(); // Close dialog
            
//             // Show error snackbar
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage),
//                 backgroundColor: Colors.red,
//                 duration: const Duration(seconds: 4),
//                 action: SnackBarAction(
//                   label: 'Retry',
//                   textColor: Colors.white,
//                   onPressed: () {
//                     _handleCategoryTap(secondaryCategoryId, categoryName);
//                   },
//                 ),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           double progress = 0.0;
//           String message = 'Checking local storage...';

//           if (state is KnowledgeDownloadingState) {
//             progress = state.progress;
//             message = 'Downloading... ${(progress * 100).toStringAsFixed(0)}%';
//           } else if (state is KnowledgeExtractingState) {
//             progress = 1.0;
//             message = 'Extracting files...';
//           } else if (state is KnowledgeLoadingState) {
//             progress = 1.0;
//             message = 'Loading from storage...';
//           }

//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SpinKitFoldingCube(
//                     color: Appcolors.kgreenlightColor,
//                     size: 50,
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     message,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   LinearProgressIndicator(
//                     value: progress,
//                     backgroundColor: Colors.grey[200],
//                     valueColor: const AlwaysStoppedAnimation<Color>(
//                       Appcolors.kgreenlightColor,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '${(progress * 100).toStringAsFixed(0)}%',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );

//   // Trigger download (will check if exists first)
//   context.read<KnowledgeBloc>().add(
//         DownloadKnowledgeEvent(
//           secondaryCategoryId: secondaryCategoryId,
//           primaryCategoryId: widget.primaryCategoryId,
//           languageId: widget.languageId,
//           forceDownload: false, // Normal download (checks cache first)
//         ),
//       );
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Appcolors.kprimarycolor.withOpacity(0.08),
//               Colors.white,
//               Appcolors.kgreenlightColor.withOpacity(0.03),
//             ],
//           ),
//         ),
//         child: CustomScrollView(
//           slivers: [
//             // Enhanced App Bar with breadcrumb
//             SliverAppBar(
//               expandedHeight: ResponsiveUtils.hp(24),
//               floating: false,
//               pinned: true,
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Appcolors.kgreenlightColor,
//                         Appcolors.kgreenlightColor.withOpacity(0.85),
//                         Appcolors.kprimarycolor.withOpacity(0.7),
//                       ],
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(35),
//                       bottomRight: Radius.circular(35),
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       // Decorative elements
//                       Positioned(
//                         top: -60,
//                         right: -60,
//                         child: Container(
//                           width: ResponsiveUtils.wp(45),
//                           height: ResponsiveUtils.wp(45),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.12),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: ResponsiveUtils.hp(10),
//                         left: -40,
//                         child: Container(
//                           width: ResponsiveUtils.wp(30),
//                           height: ResponsiveUtils.wp(30),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.08),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: ResponsiveUtils.hp(2),
//                         right: ResponsiveUtils.wp(8),
//                         child: Container(
//                           width: ResponsiveUtils.wp(20),
//                           height: ResponsiveUtils.wp(20),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.06),
//                           ),
//                         ),
//                       ),
//                       // Content
//                       Positioned(
//                         bottom: ResponsiveUtils.hp(3.5),
//                         left: ResponsiveUtils.wp(6),
//                         right: ResponsiveUtils.wp(6),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // Breadcrumb
//                             Padding(
//                               padding: EdgeInsets.only(
//                                 bottom: ResponsiveUtils.hp(0.8),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.home_rounded,
//                                     color: Colors.white.withOpacity(0.8),
//                                     size: ResponsiveUtils.wp(4),
//                                   ),
//                                   SizedBox(width: ResponsiveUtils.wp(1.5)),
//                                   Text(
//                                     widget.parentCategory,
//                                     style: TextStyle(
//                                       color: Colors.white.withOpacity(0.85),
//                                       fontSize: ResponsiveUtils.wp(3.2),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   SizedBox(width: ResponsiveUtils.wp(1.5)),
//                                   Icon(
//                                     Icons.chevron_right,
//                                     color: Colors.white.withOpacity(0.8),
//                                     size: ResponsiveUtils.wp(4.5),
//                                   ),
//                                   SizedBox(width: ResponsiveUtils.wp(1.5)),
//                                   Flexible(
//                                     child: Text(
//                                       widget.heading,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: ResponsiveUtils.wp(3.2),
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Main heading
//                             Text(
//                               widget.heading,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: ResponsiveUtils.wp(7.5),
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1.1,
//                                 shadows: const [
//                                   Shadow(
//                                     color: Colors.black26,
//                                     offset: Offset(0, 2),
//                                     blurRadius: 8,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: ResponsiveUtils.hp(0.8)),
//                             // Subtitle with category count
//                             BlocBuilder<FetchSecondarycategoryBloc,
//                                 FetchSecondarycategoryState>(
//                               builder: (context, state) {
//                                 String subtitle =
//                                     'Explore subcategories and learn more';
//                                 if (state is FetchSecondarycategorySuccessState) {
//                                   final count = state.secondarycategories.length;
//                                   subtitle =
//                                       '$count ${count == 1 ? 'category' : 'categories'} available';
//                                 }
//                                 return Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 8,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.2),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Text(
//                                         subtitle,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: ResponsiveUtils.wp(3.5),
//                                           fontWeight: FontWeight.w600,
//                                           letterSpacing: 0.3,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Collapsed app bar
//               title: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.25),
//                     width: 1,
//                   ),
//                 ),
//                 child: Text(
//                   widget.heading,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 0.8,
//                   ),
//                 ),
//               ),
//               centerTitle: true,
//               leading: Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.25),
//                     width: 1,
//                   ),
//                 ),
//                 child: IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(
//                     Icons.arrow_back_ios_new,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ),
//             // Grid Content
//             BlocBuilder<FetchSecondarycategoryBloc,
//                 FetchSecondarycategoryState>(
//               builder: (context, state) {
//                 if (state is FetchSecondarycategoryLoading) {
//                   return const SliverFillRemaining(
//                     hasScrollBody: false,
//                     child: Center(
//                       child: SpinKitFoldingCube(
//                         size: 50,
//                         color: Appcolors.kgreenlightColor,
//                       ),
//                     ),
//                   );
//                 } else if (state is FetchSecondarycategoryErrorState) {
//                   return SliverFillRemaining(
//                     hasScrollBody: false,
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                             decoration: BoxDecoration(
//                               color: Colors.red.shade50,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.error_outline_rounded,
//                               size: ResponsiveUtils.wp(15),
//                               color: Colors.red.shade400,
//                             ),
//                           ),
//                           SizedBox(height: ResponsiveUtils.hp(2.5)),
//                           Text(
//                             'Oops! Something went wrong',
//                             style: TextStyle(
//                               fontSize: ResponsiveUtils.wp(5),
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                           SizedBox(height: ResponsiveUtils.hp(1)),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: ResponsiveUtils.wp(10),
//                             ),
//                             child: Text(
//                               state.errorMessage,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: ResponsiveUtils.wp(3.5),
//                                 color: Colors.grey.shade600,
//                                 height: 1.4,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: ResponsiveUtils.hp(3)),
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               context
//                                   .read<FetchSecondarycategoryBloc>()
//                                   .add(
//                                     FetchsecondaryCategoryButtonClickEvent(
//                                       category: widget.heading,
//                                       primaryCategoryId: widget.primaryCategoryId,
//                                       languageId: widget.languageId,
//                                     ),
//                                   );
//                             },
//                             icon: const Icon(Icons.refresh_rounded),
//                             label: const Text('Try Again'),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Appcolors.kgreenlightColor,
//                               foregroundColor: Colors.white,
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: ResponsiveUtils.wp(8),
//                                 vertical: ResponsiveUtils.hp(1.5),
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 } else if (state is FetchSecondarycategorySuccessState) {
//                   if (state.secondarycategories.isEmpty) {
//                     return SliverFillRemaining(
//                       hasScrollBody: false,
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//                               decoration: BoxDecoration(
//                                 color: Appcolors.kgreenlightColor.withOpacity(0.1),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.category_outlined,
//                                 size: ResponsiveUtils.wp(20),
//                                 color: Appcolors.kgreenlightColor,
//                               ),
//                             ),
//                             SizedBox(height: ResponsiveUtils.hp(3)),
//                             Text(
//                               'No Categories Yet',
//                               style: TextStyle(
//                                 fontSize: ResponsiveUtils.wp(5.5),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey.shade800,
//                               ),
//                             ),
//                             SizedBox(height: ResponsiveUtils.hp(1)),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: ResponsiveUtils.wp(12),
//                               ),
//                               child: Text(
//                                 'There are no subcategories available in this section yet.',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: ResponsiveUtils.wp(3.8),
//                                   color: Colors.grey.shade600,
//                                   height: 1.4,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }

//                   return SliverPadding(
//                     padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                     sliver: SliverGrid(
//                       delegate: SliverChildBuilderDelegate(
//                         childCount: state.secondarycategories.length,
//                         (context, index) {
//                           final category = state.secondarycategories[index];
//                           return NetworkimageCategorycontainer(
//                             title: category.categoryName,
//                               imageUrl: '${Endpoints.imagebaseUrl}/${category.categoryPicture}',
//                             onTap: () {
//                               _handleCategoryTap(
//                                 category.secondaryCategoryId,
//                                 category.categoryName,
//                               );
//                             },
//                           );
//                         },
//                       ),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: ResponsiveUtils.wp(100) > 600 ? 3 : 2,
//                         childAspectRatio: 0.85,
//                         crossAxisSpacing: ResponsiveUtils.wp(3),
//                         mainAxisSpacing: ResponsiveUtils.hp(2),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return const SliverToBoxAdapter(child: SizedBox.shrink());
//                 }
//               },
//             ),
//             // Bottom spacing
//             SliverToBoxAdapter(
//               child: SizedBox(height: ResponsiveUtils.hp(3)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void _showRedownloadConfirmation(int secondaryCategoryId, String categoryName) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       title: Row(
//         children: [
//           Icon(
//             Icons.download_rounded,
//             color: Appcolors.kgreenlightColor,
//             size: 28,
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text(
//               'Re-download Content?',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'This will download fresh content for "$categoryName" and replace the existing data.',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[700],
//               height: 1.4,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.orange.shade50,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Colors.orange.shade200,
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.info_outline,
//                   color: Colors.orange.shade700,
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     'This may use mobile data',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.orange.shade900,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text(
//             'Cancel',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         ElevatedButton.icon(
//           onPressed: () {
//             Navigator.of(context).pop(); // Close confirmation dialog
            
//             // Start re-download with forceDownload = true
//             _handleCategoryTap(secondaryCategoryId, categoryName);
            
//             // Trigger force download
//             context.read<KnowledgeBloc>().add(
//                   DownloadKnowledgeEvent(
//                     secondaryCategoryId: secondaryCategoryId,
//                     primaryCategoryId: widget.primaryCategoryId,
//                     languageId: widget.languageId,
//                     forceDownload: true, // Force re-download
//                   ),
//                 );
//           },
//           icon: const Icon(Icons.download_rounded, size: 18),
//           label: const Text('Re-download'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Appcolors.kgreenlightColor,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 12,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }
////////////////////////////////
// class SecondaryCategoriesPage extends StatefulWidget {
//   final String heading;
//   final int primaryCategoryId;
//   final int languageId;
//   final String parentCategory;
  
//   const SecondaryCategoriesPage({
//     super.key,
//     required this.heading,
//     required this.primaryCategoryId,
//     required this.languageId,
//     required this.parentCategory,
//   });

//   @override
//   State<SecondaryCategoriesPage> createState() => _SecondaryCategoriesPageState();
// }

// class _SecondaryCategoriesPageState extends State<SecondaryCategoriesPage> {
//   // Track which categories are downloaded
//   final Map<int, bool> _downloadedCategories = {};
//   bool _isDownloadInProgress = false;

//   @override
//   void initState() {
//     super.initState();
//     context.read<FetchSecondarycategoryBloc>().add(
//           FetchsecondaryCategoryButtonClickEvent(
//             category: widget.parentCategory,
//             primaryCategoryId: widget.primaryCategoryId,
//             languageId: widget.languageId,
//           ),
//         );
//   }

//   // Check download status when categories are loaded
//   void _checkDownloadedCategories(List<dynamic> categories) async {
//     final categoryIds = categories
//         .map((cat) => cat.secondaryCategoryId as int)
//         .toList();
    
//     // Use the new BLoC event to check all at once
//     context.read<KnowledgeBloc>().add(
//       CheckMultipleKnowledgeStatusEvent(secondaryCategoryIds: categoryIds),
//     );
//   }

//   void _handleCategoryTap(int secondaryCategoryId, String categoryName, bool hasDownloadableContent, bool isDownloaded) {
//     // If no downloadable content, show info message
//     if (!hasDownloadableContent) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No content available for this category yet'),
//           backgroundColor: Colors.orange,
//           duration: Duration(seconds: 3),
//         ),
//       );
//       return;
//     }

//     log('=== CATEGORY TAPPED ===');
//     log('Category: $categoryName');
//     log('Secondary Category ID: $secondaryCategoryId');
//     log('Is Downloaded: $isDownloaded');

//     setState(() {
//       _isDownloadInProgress = true;
//     });

//     // Show loading dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (dialogContext) => BlocProvider.value(
//         value: context.read<KnowledgeBloc>(),
//         child: BlocConsumer<KnowledgeBloc, KnowledgeState>(
//           listener: (context, state) {
//             if (state is KnowledgeSuccessState) {
//               log('Knowledge loaded successfully');
//               Navigator.of(dialogContext).pop(); // Close dialog
              
//               // Update the download status
//               setState(() {
//                 _downloadedCategories[secondaryCategoryId] = true;
//                 _isDownloadInProgress = false;
//               });

//               // Navigate to individual page with content
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ScreenIndividualPage(
//                     contents: state.contents,
//                     categoryName: categoryName,
//                   ),
//                 ),
//               );
//             } else if (state is KnowledgeFailureState) {
//               log('Knowledge download/load failed');
//               Navigator.of(dialogContext).pop(); // Close dialog
              
//               setState(() {
//                 _isDownloadInProgress = false;
//               });

//               // Show error snackbar
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.errorMessage),
//                   backgroundColor: Colors.red,
//                   duration: const Duration(seconds: 4),
//                   action: SnackBarAction(
//                     label: 'Retry',
//                     textColor: Colors.white,
//                     onPressed: () {
//                       _handleCategoryTap(secondaryCategoryId, categoryName, hasDownloadableContent, isDownloaded);
//                     },
//                   ),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             double progress = 0.0;
//             String message = 'Checking local storage...';

//             if (state is KnowledgeDownloadingState) {
//               progress = state.progress;
//               message = 'Downloading... ${(progress * 100).toStringAsFixed(0)}%';
//             } else if (state is KnowledgeExtractingState) {
//               progress = 1.0;
//               message = 'Extracting files...';
//             } else if (state is KnowledgeLoadingState) {
//               progress = 1.0;
//               message = 'Loading from storage...';
//             }

//             return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SpinKitFoldingCube(
//                       color: Appcolors.kgreenlightColor,
//                       size: 50,
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       message,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     LinearProgressIndicator(
//                       value: progress,
//                       backgroundColor: Colors.grey[200],
//                       valueColor: const AlwaysStoppedAnimation<Color>(
//                         Appcolors.kgreenlightColor,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${(progress * 100).toStringAsFixed(0)}%',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );

//     // Trigger download (will check if exists first)
//     context.read<KnowledgeBloc>().add(
//           DownloadKnowledgeEvent(
//             secondaryCategoryId: secondaryCategoryId,
//             primaryCategoryId: widget.primaryCategoryId,
//             languageId: widget.languageId,
//             forceDownload: false,
//           ),
//         );
//   }

//   void _handleRefreshTap(int secondaryCategoryId, String categoryName) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: const Row(
//           children: [
//             Icon(
//               Icons.refresh_rounded,
//               color: Appcolors.kgreenlightColor,
//               size: 28,
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 'Refresh Content?',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'This will download fresh content for "$categoryName" and replace the existing data.',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//                 height: 1.4,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.orange.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: Colors.orange.shade200,
//                   width: 1,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.info_outline,
//                     color: Colors.orange.shade700,
//                     size: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'This may use mobile data',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.orange.shade900,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close confirmation
              
//               setState(() {
//                 _isDownloadInProgress = true;
//               });

//               // Show loading dialog for refresh
//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (dialogContext) => BlocProvider.value(
//                   value: context.read<KnowledgeBloc>(),
//                   child: BlocConsumer<KnowledgeBloc, KnowledgeState>(
//                     listener: (context, state) {
//                       if (state is KnowledgeSuccessState) {
//                         Navigator.of(dialogContext).pop();
                        
//                         setState(() {
//                           _downloadedCategories[secondaryCategoryId] = true;
//                           _isDownloadInProgress = false;
//                         });

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Content refreshed successfully'),
//                             backgroundColor: Appcolors.kgreenlightColor,
//                             duration: Duration(seconds: 2),
//                           ),
//                         );

//                         // Navigate to content
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => ScreenIndividualPage(
//                               contents: state.contents,
//                               categoryName: categoryName,
//                             ),
//                           ),
//                         );
//                       } else if (state is KnowledgeFailureState) {
//                         Navigator.of(dialogContext).pop();
                        
//                         setState(() {
//                           _isDownloadInProgress = false;
//                         });

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(state.errorMessage),
//                             backgroundColor: Colors.red,
//                             duration: const Duration(seconds: 4),
//                           ),
//                         );
//                       }
//                     },
//                     builder: (context, state) {
//                       double progress = 0.0;
//                       String message = 'Preparing to refresh...';

//                       if (state is KnowledgeDownloadingState) {
//                         progress = state.progress;
//                         message = 'Downloading... ${(progress * 100).toStringAsFixed(0)}%';
//                       } else if (state is KnowledgeExtractingState) {
//                         progress = 1.0;
//                         message = 'Extracting files...';
//                       }

//                       return Dialog(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(24),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const SpinKitFoldingCube(
//                                 color: Appcolors.kgreenlightColor,
//                                 size: 50,
//                               ),
//                               const SizedBox(height: 24),
//                               Text(
//                                 message,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               LinearProgressIndicator(
//                                 value: progress,
//                                 backgroundColor: Colors.grey[200],
//                                 valueColor: const AlwaysStoppedAnimation<Color>(
//                                   Appcolors.kgreenlightColor,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 '${(progress * 100).toStringAsFixed(0)}%',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );

//               // Trigger force download
//               context.read<KnowledgeBloc>().add(
//                     DownloadKnowledgeEvent(
//                       secondaryCategoryId: secondaryCategoryId,
//                       primaryCategoryId: widget.primaryCategoryId,
//                       languageId: widget.languageId,
//                       forceDownload: true,
//                     ),
//                   );
//             },
//             icon: const Icon(Icons.refresh_rounded, size: 18),
//             label: const Text('Refresh'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Appcolors.kgreenlightColor,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 12,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         // decoration: BoxDecoration(
//         //   gradient: LinearGradient(
//         //     begin: Alignment.topCenter,
//         //     end: Alignment.bottomCenter,
//         //     colors: [
//         //       Appcolors.kprimarycolor.withOpacity(0.08),
//         //       Colors.white,
//         //       Appcolors.kgreenlightColor.withOpacity(0.03),
//         //     ],
//         //   ),
//         // ),
//         child: CustomScrollView(
//           slivers: [
//             // App Bar (keeping your existing design)
//             SliverAppBar(
//               expandedHeight: ResponsiveUtils.hp(24),
//               floating: false,
//               pinned: true,
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Appcolors.kgreenlightColor,
//                         Appcolors.kgreenlightColor.withOpacity(0.85),
//                         Appcolors.kprimarycolor.withOpacity(0.7),
//                       ],
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(35),
//                       bottomRight: Radius.circular(35),
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       // Decorative elements (keeping your existing design)
//                       Positioned(
//                         top: -60,
//                         right: -60,
//                         child: Container(
//                           width: ResponsiveUtils.wp(45),
//                           height: ResponsiveUtils.wp(45),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.12),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: ResponsiveUtils.hp(3.5),
//                         left: ResponsiveUtils.wp(6),
//                         right: ResponsiveUtils.wp(6),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               widget.heading,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: ResponsiveUtils.wp(7.5),
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1.1,
//                               ),
//                             ),
//                             SizedBox(height: ResponsiveUtils.hp(0.8)),
//                             BlocBuilder<FetchSecondarycategoryBloc,
//                                 FetchSecondarycategoryState>(
//                               builder: (context, state) {
//                                 String subtitle = 'Explore subcategories';
//                                 if (state is FetchSecondarycategorySuccessState) {
//                                   final count = state.secondarycategories.length;
//                                   subtitle = '$count ${count == 1 ? 'category' : 'categories'} available';
//                                 }
//                                 return Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 8,
//                                     vertical: 4,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     subtitle,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: ResponsiveUtils.wp(3.5),
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               title: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   widget.heading,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               centerTitle: true,
//               leading: Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(
//                     Icons.arrow_back_ios_new,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ),
//             // Grid Content with MultiBlocListener
//             MultiBlocListener(
//               listeners: [
//                 // Listen to category fetch success to check download status
//                 BlocListener<FetchSecondarycategoryBloc, FetchSecondarycategoryState>(
//                   listener: (context, state) {
//                     if (state is FetchSecondarycategorySuccessState) {
//                       _checkDownloadedCategories(state.secondarycategories);
//                     }
//                   },
//                 ),
//                 // Listen to knowledge status updates
//                 BlocListener<KnowledgeBloc, KnowledgeState>(
//                   listener: (context, state) {
//                     if (state is KnowledgeMultipleStatusState) {
//                       setState(() {
//                         _downloadedCategories.addAll(state.downloadStatus);
//                       });
//                     }
//                   },
//                 ),
//               ],
//               child: BlocBuilder<FetchSecondarycategoryBloc, FetchSecondarycategoryState>(
//                 builder: (context, state) {
//                   if (state is FetchSecondarycategoryLoading) {
//                     return const SliverFillRemaining(
//                       hasScrollBody: false,
//                       child: Center(
//                         child: SpinKitFoldingCube(
//                           size: 50,
//                           color: Appcolors.kgreenlightColor,
//                         ),
//                       ),
//                     );
//                   } else if (state is FetchSecondarycategoryErrorState) {
//                     return SliverFillRemaining(
//                       hasScrollBody: false,
//                       child: Center(
//                         child: Text(state.errorMessage),
//                       ),
//                     );
//                   } else if (state is FetchSecondarycategorySuccessState) {
//                     if (state.secondarycategories.isEmpty) {
//                       return const SliverFillRemaining(
//                         hasScrollBody: false,
//                         child: Center(
//                           child: Text('No categories available'),
//                         ),
//                       );
//                     }

//                     return SliverPadding(
//                       padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                       sliver: SliverGrid(
//                         delegate: SliverChildBuilderDelegate(
//                           childCount: state.secondarycategories.length,
//                           (context, index) {
//                             final category = state.secondarycategories[index];
//                             final isDownloaded = _downloadedCategories[category.secondaryCategoryId] ?? false;
//                             final hasDownloadableContent = true;
                            
//                             return EnhancedCategoryCard(
//                               title: category.categoryName,
//                               imageUrl: '${Endpoints.imagebaseUrl}/${category.categoryPicture}',
//                               isDownloaded: isDownloaded,
//                               hasDownloadableContent: hasDownloadableContent,
//                               isDownloadInProgress: _isDownloadInProgress,
//                               onTitleTap: () {
//                                 _handleCategoryTap(
//                                   category.secondaryCategoryId,
//                                   category.categoryName,
//                                   hasDownloadableContent,
//                                   isDownloaded,
//                                 );
//                               },
//                               onDownloadTap: () {
//                                 if (isDownloaded) {
//                                   _handleRefreshTap(
//                                     category.secondaryCategoryId,
//                                     category.categoryName,
//                                   );
//                                 } else {
//                                   _handleCategoryTap(
//                                     category.secondaryCategoryId,
//                                     category.categoryName,
//                                     hasDownloadableContent,
//                                     isDownloaded,
//                                   );
//                                 }
//                               },
//                             );
//                           },
//                         ),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: ResponsiveUtils.wp(100) > 600 ? 3 : 2,
//                           childAspectRatio: 0.85,
//                           crossAxisSpacing: ResponsiveUtils.wp(3),
//                           mainAxisSpacing: ResponsiveUtils.hp(2),
//                         ),
//                       ),
//                     );
//                   }
//                   return const SliverToBoxAdapter(child: SizedBox.shrink());
//                 },
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: SizedBox(height: ResponsiveUtils.hp(3)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Enhanced Category Card Widget
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:langlex/presentation/blocs/knowledge_bloc/knowledge_bloc.dart';
import 'package:langlex/presentation/blocs/fetch_secondary_category_bloc/fetch_secondarycategory_bloc.dart';
import 'package:langlex/presentation/screens/individual_contentpage/individualpage.dart';
import 'package:langlex/presentation/screens/primary_categories/widgets/networkimage_categorycontainer.dart';
import 'dart:developer';
import 'package:langlex/presentation/screens/secondary_categories/widgets/networkimage_category_container.dart';

class SecondaryCategoriesPage extends StatefulWidget {
  final String heading;
  final int primaryCategoryId;
  final int languageId;
  final String parentCategory;
  
  const SecondaryCategoriesPage({
    super.key,
    required this.heading,
    required this.primaryCategoryId,
    required this.languageId,
    required this.parentCategory,
  });

  @override
  State<SecondaryCategoriesPage> createState() => _SecondaryCategoriesPageState();
}

class _SecondaryCategoriesPageState extends State<SecondaryCategoriesPage> {
  // Track which categories are downloaded
  final Map<int, bool> _downloadedCategories = {};
  bool _isDownloadInProgress = false;

  @override
  void initState() {
    super.initState();
    context.read<FetchSecondarycategoryBloc>().add(
          FetchsecondaryCategoryButtonClickEvent(
            category: widget.parentCategory,
            primaryCategoryId: widget.primaryCategoryId,
            languageId: widget.languageId,
          ),
        );
  }

  // Check download status when categories are loaded
  void _checkDownloadedCategories(List<dynamic> categories) async {
    final categoryIds = categories
        .map((cat) => cat.secondaryCategoryId as int)
        .toList();
    
    // Use the new BLoC event to check all at once
    context.read<KnowledgeBloc>().add(
      CheckMultipleKnowledgeStatusEvent(secondaryCategoryIds: categoryIds),
    );
  }

  void _handleCategoryTap(int secondaryCategoryId, String categoryName, bool hasDownloadableContent, bool isDownloaded) {
    // If no downloadable content, show info message
    if (!hasDownloadableContent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No content available for this category yet'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    log('=== CATEGORY TAPPED ===');
    log('Category: $categoryName');
    log('Secondary Category ID: $secondaryCategoryId');
    log('Is Downloaded: $isDownloaded');

    setState(() {
      _isDownloadInProgress = true;
    });

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<KnowledgeBloc>(),
        child: BlocConsumer<KnowledgeBloc, KnowledgeState>(
          listener: (context, state) {
            if (state is KnowledgeSuccessState) {
              log('Knowledge loaded successfully');
              Navigator.of(dialogContext).pop(); // Close dialog
              
              // Update the download status
              setState(() {
                _downloadedCategories[secondaryCategoryId] = true;
                _isDownloadInProgress = false;
              });

              // Navigate to individual page with content
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScreenIndividualPage(
                    contents: state.contents,
                    categoryName: categoryName,
                  ),
                ),
              );
            } else if (state is KnowledgeFailureState) {
              log('Knowledge download/load failed');
              Navigator.of(dialogContext).pop(); // Close dialog
              
              setState(() {
                _isDownloadInProgress = false;
              });

              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: () {
                      _handleCategoryTap(secondaryCategoryId, categoryName, hasDownloadableContent, isDownloaded);
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            double progress = 0.0;
            String message = 'Checking local storage...';

            if (state is KnowledgeDownloadingState) {
              progress = state.progress;
              message = 'Downloading... ${(progress * 100).toStringAsFixed(0)}%';
            } else if (state is KnowledgeExtractingState) {
              progress = 1.0;
              message = 'Extracting files...';
            } else if (state is KnowledgeLoadingState) {
              progress = 1.0;
              message = 'Loading from storage...';
            }

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SpinKitFoldingCube(
                      color: Appcolors.kgreenlightColor,
                      size: 50,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Appcolors.kgreenlightColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

    // Trigger download (will check if exists first)
    context.read<KnowledgeBloc>().add(
          DownloadKnowledgeEvent(
            secondaryCategoryId: secondaryCategoryId,
            primaryCategoryId: widget.primaryCategoryId,
            languageId: widget.languageId,
            forceDownload: false,
          ),
        );
  }

  void _handleRefreshTap(int secondaryCategoryId, String categoryName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.refresh_rounded,
              color: Appcolors.kgreenlightColor,
              size: 28,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Refresh Content?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This will download fresh content for "$categoryName" and replace the existing data.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.shade200,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This may use mobile data',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop(); // Close confirmation
              
              setState(() {
                _isDownloadInProgress = true;
              });

              // Show loading dialog for refresh
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) => BlocProvider.value(
                  value: context.read<KnowledgeBloc>(),
                  child: BlocConsumer<KnowledgeBloc, KnowledgeState>(
                    listener: (context, state) {
                      if (state is KnowledgeSuccessState) {
                        Navigator.of(dialogContext).pop();
                        
                        setState(() {
                          _downloadedCategories[secondaryCategoryId] = true;
                          _isDownloadInProgress = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Content refreshed successfully'),
                            backgroundColor: Appcolors.kgreenlightColor,
                            duration: Duration(seconds: 2),
                          ),
                        );

                        // Navigate to content
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ScreenIndividualPage(
                              contents: state.contents,
                              categoryName: categoryName,
                            ),
                          ),
                        );
                      } else if (state is KnowledgeFailureState) {
                        Navigator.of(dialogContext).pop();
                        
                        setState(() {
                          _isDownloadInProgress = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 4),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      double progress = 0.0;
                      String message = 'Preparing to refresh...';

                      if (state is KnowledgeDownloadingState) {
                        progress = state.progress;
                        message = 'Downloading... ${(progress * 100).toStringAsFixed(0)}%';
                      } else if (state is KnowledgeExtractingState) {
                        progress = 1.0;
                        message = 'Extracting files...';
                      }

                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SpinKitFoldingCube(
                                color: Appcolors.kgreenlightColor,
                                size: 50,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                message,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Appcolors.kgreenlightColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${(progress * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );

              // Trigger force download
              context.read<KnowledgeBloc>().add(
                    DownloadKnowledgeEvent(
                      secondaryCategoryId: secondaryCategoryId,
                      primaryCategoryId: widget.primaryCategoryId,
                      languageId: widget.languageId,
                      forceDownload: true,
                    ),
                  );
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.kgreenlightColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
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
              Appcolors.kprimarycolor.withOpacity(0.08),
              Colors.white,
              Appcolors.kgreenlightColor.withOpacity(0.03),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Enhanced App Bar with breadcrumb
            SliverAppBar(
              expandedHeight: ResponsiveUtils.hp(24),
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
                        Appcolors.kgreenlightColor,
                        Appcolors.kgreenlightColor.withOpacity(0.85),
                        Appcolors.kprimarycolor.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative elements
                      Positioned(
                        top: -60,
                        right: -60,
                        child: Container(
                          width: ResponsiveUtils.wp(45),
                          height: ResponsiveUtils.wp(45),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ResponsiveUtils.hp(10),
                        left: -40,
                        child: Container(
                          width: ResponsiveUtils.wp(30),
                          height: ResponsiveUtils.wp(30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: ResponsiveUtils.hp(2),
                        right: ResponsiveUtils.wp(8),
                        child: Container(
                          width: ResponsiveUtils.wp(20),
                          height: ResponsiveUtils.wp(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.06),
                          ),
                        ),
                      ),
                      // Content with breadcrumb
                      Positioned(
                        bottom: ResponsiveUtils.hp(3.5),
                        left: ResponsiveUtils.wp(6),
                        right: ResponsiveUtils.wp(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Breadcrumb
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: ResponsiveUtils.hp(0.8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home_rounded,
                                    color: Colors.white.withOpacity(0.8),
                                    size: ResponsiveUtils.wp(4),
                                  ),
                                  SizedBox(width: ResponsiveUtils.wp(1.5)),
                                  Text(
                                    widget.parentCategory,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: ResponsiveUtils.wp(3.2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: ResponsiveUtils.wp(1.5)),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.white.withOpacity(0.8),
                                    size: ResponsiveUtils.wp(4.5),
                                  ),
                                  SizedBox(width: ResponsiveUtils.wp(1.5)),
                                  Flexible(
                                    child: Text(
                                      widget.heading,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveUtils.wp(3.2),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Main heading
                            Text(
                              widget.heading,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveUtils.wp(7.5),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(0.8)),
                            // Subtitle with category count
                            BlocBuilder<FetchSecondarycategoryBloc,
                                FetchSecondarycategoryState>(
                              builder: (context, state) {
                                String subtitle =
                                    'Explore subcategories and learn more';
                                if (state is FetchSecondarycategorySuccessState) {
                                  final count = state.secondarycategories.length;
                                  subtitle =
                                      '$count ${count == 1 ? 'category' : 'categories'} available';
                                }
                                return Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        subtitle,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ResponsiveUtils.wp(3.5),
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Collapsed app bar
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.heading,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
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
                    color: Colors.white.withOpacity(0.25),
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
            // Grid Content with MultiBlocListener
            MultiBlocListener(
              listeners: [
                // Listen to category fetch success to check download status
                BlocListener<FetchSecondarycategoryBloc, FetchSecondarycategoryState>(
                  listener: (context, state) {
                    if (state is FetchSecondarycategorySuccessState) {
                      _checkDownloadedCategories(state.secondarycategories);
                    }
                  },
                ),
                // Listen to knowledge status updates
                BlocListener<KnowledgeBloc, KnowledgeState>(
                  listener: (context, state) {
                    if (state is KnowledgeMultipleStatusState) {
                      setState(() {
                        _downloadedCategories.addAll(state.downloadStatus);
                      });
                    }
                  },
                ),
              ],
              child: BlocBuilder<FetchSecondarycategoryBloc, FetchSecondarycategoryState>(
                builder: (context, state) {
                  if (state is FetchSecondarycategoryLoading) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: SpinKitFoldingCube(
                          size: 50,
                          color: Appcolors.kgreenlightColor,
                        ),
                      ),
                    );
                  } else if (state is FetchSecondarycategoryErrorState) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.error_outline_rounded,
                                size: ResponsiveUtils.wp(15),
                                color: Colors.red.shade400,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2.5)),
                            Text(
                              'Oops! Something went wrong',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(5),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(10),
                              ),
                              child: Text(
                                state.errorMessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.wp(3.5),
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(3)),
                            ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<FetchSecondarycategoryBloc>()
                                    .add(
                                      FetchsecondaryCategoryButtonClickEvent(
                                        category: widget.heading,
                                        primaryCategoryId: widget.primaryCategoryId,
                                        languageId: widget.languageId,
                                      ),
                                    );
                              },
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Try Again'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolors.kgreenlightColor,
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
                    );
                  } else if (state is FetchSecondarycategorySuccessState) {
                    if (state.secondarycategories.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                                decoration: BoxDecoration(
                                  color: Appcolors.kgreenlightColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.category_outlined,
                                  size: ResponsiveUtils.wp(20),
                                  color: Appcolors.kgreenlightColor,
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.hp(3)),
                              Text(
                                'No Categories Yet',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.wp(5.5),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.hp(1)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.wp(12),
                                ),
                                child: Text(
                                  'There are no subcategories available in this section yet.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.wp(3.8),
                                    color: Colors.grey.shade600,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.secondarycategories.length,
                          (context, index) {
                            final category = state.secondarycategories[index];
                            final isDownloaded = _downloadedCategories[category.secondaryCategoryId] ?? false;
                            final hasDownloadableContent = true;
                            
                            return EnhancedCategoryCard(
                              title: category.categoryName,
                              imageUrl: '${Endpoints.imagebaseUrl}/${category.categoryPicture}',
                              isDownloaded: isDownloaded,
                              hasDownloadableContent: hasDownloadableContent,
                              isDownloadInProgress: _isDownloadInProgress,
                              onTitleTap: () {
                                _handleCategoryTap(
                                  category.secondaryCategoryId,
                                  category.categoryName,
                                  hasDownloadableContent,
                                  isDownloaded,
                                );
                              },
                              onDownloadTap: () {
                                if (isDownloaded) {
                                  _handleRefreshTap(
                                    category.secondaryCategoryId,
                                    category.categoryName,
                                  );
                                } else {
                                  _handleCategoryTap(
                                    category.secondaryCategoryId,
                                    category.categoryName,
                                    hasDownloadableContent,
                                    isDownloaded,
                                  );
                                }
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
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ),
            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: ResponsiveUtils.hp(3)),
            ),
          ],
        ),
      ),
    );
  }
}