// import 'package:flutter/material.dart';

// @immutable
// sealed class KnowledgeEvent {}

// /// Check if a single category's knowledge is already downloaded locally.
// class CheckLocalKnowledgeEvent extends KnowledgeEvent {
//   final int secondaryCategoryId;
//   CheckLocalKnowledgeEvent({required this.secondaryCategoryId});
// }

// /// Check multiple categories at once for local download status.
// class CheckMultipleKnowledgeStatusEvent extends KnowledgeEvent {
//   final List<int> secondaryCategoryIds;
//   CheckMultipleKnowledgeStatusEvent({required this.secondaryCategoryIds});
// }

// /// Load a single category's knowledge from local storage.
// class LoadLocalKnowledgeEvent extends KnowledgeEvent {
//   final int secondaryCategoryId;
//   LoadLocalKnowledgeEvent({required this.secondaryCategoryId});
// }

// /// Download (and extract) a category's knowledge.
// /// If [forceDownload] is false, the bloc will first check local cache.
// class DownloadKnowledgeEvent extends KnowledgeEvent {
//   final int secondaryCategoryId;
//   final int primaryCategoryId;
//   final int languageId;
//   final bool forceDownload;

//   DownloadKnowledgeEvent({
//     required this.secondaryCategoryId,
//     required this.primaryCategoryId,
//     required this.languageId,
//     this.forceDownload = false,
//   });
// }
import 'package:meta/meta.dart';

@immutable
abstract class KnowledgeEvent {
  const KnowledgeEvent();
}

/// Check if local data exists for a single category (for quick badges / UI)
class CheckLocalKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;
  const CheckLocalKnowledgeEvent({required this.secondaryCategoryId});
}

/// Batch check multiple categories at once (optional but handy on list load)
class CheckMultipleKnowledgeStatusEvent extends KnowledgeEvent {
  final List<int> secondaryCategoryIds;
  const CheckMultipleKnowledgeStatusEvent({required this.secondaryCategoryIds});
}

/// Load local knowledge to navigate to details screen
class LoadLocalKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;
  const LoadLocalKnowledgeEvent({required this.secondaryCategoryId});
}
