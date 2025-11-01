// // ALTERNATIVE APPROACH: Update your existing NetworkimageCategorycontainer widget
// // Add these new parameters to make it work with the updated page

// import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';

// class NetworkimageCategorycontainer extends StatelessWidget {
//   final String title;
//   final String imageUrl;
//   final VoidCallback? onTap;
//   final bool isDownloaded;
//   final bool hasDownloadableContent;
//   final bool isDownloadInProgress;
//   final VoidCallback? onDownloadTap;
//   final VoidCallback? onTitleTap;

//   const NetworkimageCategorycontainer({
//     super.key,
//     required this.title,
//     required this.imageUrl,
//     this.onTap, // Keep for backward compatibility
//     this.isDownloaded = false,
//     this.hasDownloadableContent = true,
//     this.isDownloadInProgress = false,
//     this.onDownloadTap,
//     this.onTitleTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Image Section (Non-tappable background)
//           Expanded(
//             flex: 3,
//             child: Stack(
//               children: [
//                 // Category Image
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl: imageUrl,
//                     width: double.infinity,
//                     height: double.infinity,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => Container(
//                       color: Colors.grey[200],
//                       child: const Center(
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Appcolors.kgreenlightColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                     errorWidget: (context, url, error) => Container(
//                       color: Colors.grey[200],
//                       child: Icon(
//                         Icons.image_not_supported_outlined,
//                         size: 40,
//                         color: Colors.grey[400],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Gradient Overlay
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           Colors.black.withOpacity(0.3),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Download/Refresh Icon (Top Right)
//                 if (hasDownloadableContent)
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: isDownloadInProgress
//                             ? null
//                             : (onDownloadTap ?? onTap),
//                         borderRadius: BorderRadius.circular(12),
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.95),
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.15),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             isDownloaded
//                                 ? Icons.refresh_rounded
//                                 : Icons.download_rounded,
//                             size: 20,
//                             color: isDownloaded
//                                 ? Appcolors.kgreenlightColor
//                                 : Colors.blue[700],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 // Coming Soon Badge for non-downloadable content
//                 if (!hasDownloadableContent)
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.withOpacity(0.95),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.15),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.schedule_rounded,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Coming Soon',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 // Downloaded Badge (Bottom Right)
//                 if (isDownloaded && hasDownloadableContent)
//                   Positioned(
//                     bottom: 8,
//                     right: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Appcolors.kgreenlightColor.withOpacity(0.95),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.check_circle,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Downloaded',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           // Title Section (Tappable)
//           Expanded(
//             flex: 2,
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: isDownloadInProgress
//                     ? null
//                     : (onTitleTap ?? onTap),
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 child: Container(
                
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 12,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black87,
//                           height: 1.2,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(
//                             hasDownloadableContent
//                                 ? Icons.arrow_forward_rounded
//                                 : Icons.info_outline_rounded,
//                             size: 14,
//                             color: hasDownloadableContent
//                                 ? Appcolors.kgreenlightColor
//                                 : Colors.orange,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             hasDownloadableContent
//                                 ? 'Tap to explore'
//                                 : 'No content yet',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: hasDownloadableContent
//                                   ? Colors.grey[600]
//                                   : Colors.orange[700],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class EnhancedCategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isDownloaded;
  final bool hasDownloadableContent;
  final bool isDownloadInProgress;
  final VoidCallback onTitleTap;
  final VoidCallback onDownloadTap;

  const EnhancedCategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.isDownloaded,
    required this.hasDownloadableContent,
    required this.isDownloadInProgress,
    required this.onTitleTap,
    required this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:const Color.fromARGB(255, 183, 234, 220),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Section (Non-tappable background)
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // Category Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Appcolors.kgreenlightColor,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                // Download/Refresh Icon (Top Right)
                if (hasDownloadableContent)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: isDownloadInProgress ? null : onDownloadTap,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isDownloaded
                                ? Icons.refresh_rounded
                                : Icons.download_rounded,
                            size: 20,
                            color: isDownloaded
                                ? Appcolors.kgreenlightColor
                                : Colors.blue[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                // Coming Soon Badge for non-downloadable content
                if (!hasDownloadableContent)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Coming Soon',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Downloaded Badge (Bottom Right)
                if (isDownloaded && hasDownloadableContent)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Appcolors.kgreenlightColor.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Downloaded',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Title Section (Tappable)
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isDownloadInProgress ? null : onTitleTap,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  //color: const Color.fromARGB(255, 220, 232, 229),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            hasDownloadableContent
                                ? Icons.arrow_forward_rounded
                                : Icons.info_outline_rounded,
                            size: 14,
                            color: hasDownloadableContent
                                ? Appcolors.kgreenlightColor
                                : Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            hasDownloadableContent
                                ? 'Tap to explore'
                                : 'No content yet',
                            style: TextStyle(
                              fontSize: 12,
                              color: hasDownloadableContent
                                  ? Colors.grey[600]
                                  : Colors.orange[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}