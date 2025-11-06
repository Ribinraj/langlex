import 'package:flutter/material.dart';

@immutable
sealed class KnowledgeEvent {}

/// Check if a single category's knowledge is already downloaded locally.
class CheckLocalKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;
  CheckLocalKnowledgeEvent({required this.secondaryCategoryId});
}

/// Check multiple categories at once for local download status.
class CheckMultipleKnowledgeStatusEvent extends KnowledgeEvent {
  final List<int> secondaryCategoryIds;
  CheckMultipleKnowledgeStatusEvent({required this.secondaryCategoryIds});
}

/// Load a single category's knowledge from local storage.
class LoadLocalKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;
  LoadLocalKnowledgeEvent({required this.secondaryCategoryId});
}

/// Download (and extract) a category's knowledge.
/// If [forceDownload] is false, the bloc will first check local cache.
class DownloadKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;
  final int primaryCategoryId;
  final int languageId;
  final bool forceDownload;

  DownloadKnowledgeEvent({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
    required this.languageId,
    this.forceDownload = false,
  });
}
