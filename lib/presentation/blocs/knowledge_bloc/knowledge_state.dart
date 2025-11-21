// part of 'knowledge_bloc.dart';

// @immutable
// sealed class KnowledgeState {}

// /// Initial state used by the Bloc constructor.
// final class KnowledgeInitial extends KnowledgeState {}

// /// Emitted while checking local cache existence.
// final class KnowledgeCheckingState extends KnowledgeState {}

// /// Emitted when loading local knowledge (file IO/parsing).
// final class KnowledgeLoadingState extends KnowledgeState {}

// /// Result of a single local-existence check.
// final class KnowledgeExistsLocallyState extends KnowledgeState {
//   final bool exists;
//   KnowledgeExistsLocallyState({required this.exists});
// }

// /// Emitted during download with progress in [0.0, 1.0].
// final class KnowledgeDownloadingState extends KnowledgeState {
//   final double progress;
//   KnowledgeDownloadingState({required this.progress});
// }

// /// Brief state while extracting the downloaded zip.
// final class KnowledgeExtractingState extends KnowledgeState {}

// /// Success with parsed content and metadata.
// final class KnowledgeSuccessState extends KnowledgeState {
//   final List<Map<String, dynamic>> contents;
//   final String extractPath;
//   final int totalItems;
//   final bool isFromCache;
//   final int? secondaryCategoryId;

//   KnowledgeSuccessState({
//     required this.contents,
//     required this.extractPath,
//     required this.totalItems,
//     this.isFromCache = false,
//     this.secondaryCategoryId,
//   });
// }

// /// Failure with a human-readable error.
// final class KnowledgeFailureState extends KnowledgeState {
//   final String errorMessage;
//   KnowledgeFailureState({required this.errorMessage});
// }

// /// Result of batch existence checks: categoryId -> downloaded?
// final class KnowledgeMultipleStatusState extends KnowledgeState {
//   final Map<int, bool> downloadStatus;
//   KnowledgeMultipleStatusState({required this.downloadStatus});
// }
part of 'knowledge_bloc.dart';

@immutable
abstract class KnowledgeState {
  const KnowledgeState();
}

class KnowledgeInitial extends KnowledgeState {
  const KnowledgeInitial();
}

class KnowledgeCheckingState extends KnowledgeState {
  const KnowledgeCheckingState();
}

class KnowledgeExistsLocallyState extends KnowledgeState {
  final bool exists;
  const KnowledgeExistsLocallyState({required this.exists});
}

class KnowledgeLoadingState extends KnowledgeState {
  const KnowledgeLoadingState();
}

class KnowledgeSuccessState extends KnowledgeState {
  final List<Map<String, dynamic>> contents;
  final String extractPath;
  final int totalItems;
  final bool isFromCache;
  final int secondaryCategoryId;

  const KnowledgeSuccessState({
    required this.contents,
    required this.extractPath,
    required this.totalItems,
    required this.isFromCache,
    required this.secondaryCategoryId,
  });
}

class KnowledgeFailureState extends KnowledgeState {
  final String errorMessage;
  const KnowledgeFailureState({required this.errorMessage});
}

/// For batch local-availability check (id -> hasLocal)
class KnowledgeMultipleStatusState extends KnowledgeState {
  final Map<int, bool> downloadStatus;
  const KnowledgeMultipleStatusState({required this.downloadStatus});
}
