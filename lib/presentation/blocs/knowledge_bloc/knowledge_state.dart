part of 'knowledge_bloc.dart';

@immutable
sealed class KnowledgeState {}

final class KnowledgeInitial extends KnowledgeState {}
class KnowledgeCheckingState extends KnowledgeState {}
// class KnowledgeExistsLocallyState extends KnowledgeState {
//   final bool exists;

//   KnowledgeExistsLocallyState({required this.exists});
// }

// class KnowledgeDownloadingState extends KnowledgeState {
//   final double progress;

//   KnowledgeDownloadingState({required this.progress});
// }

// class KnowledgeExtractingState extends KnowledgeState {}

// class KnowledgeSuccessState extends KnowledgeState {
//   final List<Map<String, dynamic>> contents;
//   final String extractPath;
//   final int totalItems;

//   KnowledgeSuccessState({
//     required this.contents,
//     required this.extractPath,
//     required this.totalItems,
//   });
// }

// class KnowledgeFailureState extends KnowledgeState {
//   final String errorMessage;

//   KnowledgeFailureState({required this.errorMessage});
// }
final class KnowledgeLoadingState extends KnowledgeState {}

final class KnowledgeExistsLocallyState extends KnowledgeState {
  final bool exists;

  KnowledgeExistsLocallyState({required this.exists});
}

final class KnowledgeDownloadingState extends KnowledgeState {
  final double progress;

  KnowledgeDownloadingState({required this.progress});
}

final class KnowledgeExtractingState extends KnowledgeState {}

final class KnowledgeSuccessState extends KnowledgeState {
  final List<Map<String, dynamic>> contents;
  final String extractPath;
  final int totalItems;
  final bool isFromCache; // Add this flag
   final int? secondaryCategoryId; 

  KnowledgeSuccessState({
    required this.contents,
    required this.extractPath,
    required this.totalItems,
    this.isFromCache = false, // Default to false
     this.secondaryCategoryId,
  });
}

final class KnowledgeFailureState extends KnowledgeState {
  final String errorMessage;

  KnowledgeFailureState({required this.errorMessage});
}
// NEW: State for multiple category status checks
class KnowledgeMultipleStatusState extends KnowledgeState {
  final Map<int, bool> downloadStatus;
  KnowledgeMultipleStatusState({required this.downloadStatus});
}