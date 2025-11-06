
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:langlex/core/colors.dart';


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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Appcolors.kbackgroundcolor,
            Colors.white,
            Appcolors.korangedoublelightColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kprimarycolor.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Appcolors.korangeColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Appcolors.kgreenlightColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Section with Enhanced Styling
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // Category Image with Border
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Appcolors.kgreenlightColor.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Appcolors.kprimarycolor.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Appcolors.kgreenlightColor.withOpacity(0.1),
                              Appcolors.korangelightColor.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Appcolors.kprimarycolor,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Appcolors.kgreycolor.withOpacity(0.1),
                              Appcolors.kgreycolor.withOpacity(0.2),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Appcolors.khinttextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // Vibrant Gradient Overlay
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Appcolors.kprimarycolor.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                ),
                // Decorative Corner Accent
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Appcolors.korangeColor.withOpacity(0.3),
                          Appcolors.kpurplecolor.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Action Button (Top Right) - Download OR Refresh
                if (hasDownloadableContent)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: isDownloadInProgress ? null : onDownloadTap,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isDownloaded
                                  ? [
                                      Appcolors.kgreenlightColor,
                                      Appcolors.kprimarycolor,
                                    ]
                                  : [
                                      Appcolors.kpurplecolor,
                                      Appcolors.korangeColor,
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: (isDownloaded
                                        ? Appcolors.kgreenlightColor
                                        : Appcolors.kpurplecolor)
                                    .withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            isDownloaded
                                ? Icons.refresh_rounded
                                : Icons.download_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                // Coming Soon Badge
                if (!hasDownloadableContent)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Appcolors.korangeColor,
                            Appcolors.korangelightColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.korangeColor.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 2,
                        ),
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
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Downloaded Badge (Bottom Right) - Colorful
                if (isDownloaded && hasDownloadableContent)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Appcolors.kgreenlightColor,
                            Appcolors.kprimarycolor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.kgreenlightColor.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 2,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Downloaded',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Title Section (Tappable) with Gradient - FIXED OVERFLOW
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isDownloadInProgress ? null : onTitleTap,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.7),
                        Appcolors.korangedoublelightColor.withOpacity(0.4),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with gradient effect - Flexible to prevent overflow
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Appcolors.kgreenlightColor.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Appcolors.ktextColor,
                              height: 1.2,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Action hint with colorful icon
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: hasDownloadableContent
                                ? (isDownloaded
                                    ? [
                                        Appcolors.kgreenlightColor.withOpacity(0.15),
                                        Appcolors.kprimarycolor.withOpacity(0.1),
                                      ]
                                    : [
                                        Appcolors.kpurplecolor.withOpacity(0.15),
                                        Appcolors.korangeColor.withOpacity(0.1),
                                      ])
                                : [
                                    Appcolors.korangeColor.withOpacity(0.15),
                                    Appcolors.korangelightColor.withOpacity(0.1),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: hasDownloadableContent
                                ? (isDownloaded
                                    ? Appcolors.kgreenlightColor.withOpacity(0.3)
                                    : Appcolors.kpurplecolor.withOpacity(0.3))
                                : Appcolors.korangeColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              hasDownloadableContent
                                  ? (isDownloaded
                                      ? Icons.play_circle_rounded
                                      : Icons.download_for_offline_rounded)
                                  : Icons.info_outline_rounded,
                              size: 14,
                              color: hasDownloadableContent
                                  ? (isDownloaded
                                      ? Appcolors.kprimarycolor
                                      : Appcolors.kpurplecolor)
                                  : Appcolors.korangeColor,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                hasDownloadableContent
                                    ? (isDownloaded ? 'Tap to view' : 'Tap to download')
                                    : 'No content yet',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  color: hasDownloadableContent
                                      ? (isDownloaded
                                          ? Appcolors.kprimarycolor
                                          : Appcolors.kpurplecolor)
                                      : Appcolors.korangeColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
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
