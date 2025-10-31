part of 'knowledge_bloc.dart';

@immutable
sealed class KnowledgeEvent {}
// class DownloadKnowledgeEvent extends KnowledgeEvent {
//   final int secondaryCategoryId;
//   final int primaryCategoryId;
//   final int languageId;

//   DownloadKnowledgeEvent({
//     required this.secondaryCategoryId,
//     required this.primaryCategoryId,
//     required this.languageId,
//   });
// }

// class LoadLocalKnowledgeEvent extends KnowledgeEvent {
//   final int secondaryCategoryId;

//   LoadLocalKnowledgeEvent({required this.secondaryCategoryId});
// }

// class CheckLocalKnowledgeEvent extends KnowledgeEvent {
//   final int secondaryCategoryId;

//   CheckLocalKnowledgeEvent({required this.secondaryCategoryId});
// }
class CheckLocalKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;

  CheckLocalKnowledgeEvent({required this.secondaryCategoryId});
}

// Load knowledge from local storage
class LoadLocalKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;

  LoadLocalKnowledgeEvent({required this.secondaryCategoryId});
}

// Download knowledge (with optional force download)
class DownloadKnowledgeEvent extends KnowledgeEvent {
  final int secondaryCategoryId;
  final int primaryCategoryId;
  final int languageId;
  final bool forceDownload; // Add this parameter

  DownloadKnowledgeEvent({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
    required this.languageId,
    this.forceDownload = false, // Default to false
  });
}