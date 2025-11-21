

// import 'dart:developer';
// import 'package:bloc/bloc.dart';


// import 'package:langlex/domain/repository/app_repo.dart';
// import 'package:langlex/presentation/blocs/knowledge_bloc/knowledge_event.dart';
// import 'package:meta/meta.dart';


// part 'knowledge_state.dart';

// class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {
//   final AppRepo repository;

//   KnowledgeBloc({required this.repository}) : super(KnowledgeInitial()) {
    
//     // Check if knowledge exists locally
//     on<CheckLocalKnowledgeEvent>((event, emit) async {
//       try {
//         log('=== CHECKING LOCAL KNOWLEDGE ===');
//         emit(KnowledgeCheckingState());
        
//         final exists = await repository.isKnowledgeDownloaded(
//           secondaryCategoryId: event.secondaryCategoryId,
//         );
        
//         log('Knowledge exists locally: $exists');
//         emit(KnowledgeExistsLocallyState(exists: exists));
//       } catch (e) {
//         log('Error checking local knowledge: $e');
//         emit(KnowledgeFailureState(
//           errorMessage: 'Failed to check local knowledge: $e',
//         ));
//       }
//     });

//     // NEW: Check multiple categories status at once
//     on<CheckMultipleKnowledgeStatusEvent>((event, emit) async {
//       try {
//         log('=== CHECKING MULTIPLE KNOWLEDGE STATUS ===');
        
//         final Map<int, bool> statusMap = {};
        
//         for (var categoryId in event.secondaryCategoryIds) {
//           final exists = await repository.isKnowledgeDownloaded(
//             secondaryCategoryId: categoryId,
//           );
//           statusMap[categoryId] = exists;
//           log('Category $categoryId - Downloaded: $exists');
//         }
        
//         emit(KnowledgeMultipleStatusState(downloadStatus: statusMap));
//       } catch (e) {
//         log('Error checking multiple knowledge status: $e');
//         emit(KnowledgeFailureState(
//           errorMessage: 'Failed to check knowledge status: $e',
//         ));
//       }
//     });

//     // Load local knowledge
//     on<LoadLocalKnowledgeEvent>((event, emit) async {
//       try {
//         log('=== LOADING LOCAL KNOWLEDGE ===');
//         emit(KnowledgeLoadingState());
        
//         final result = await repository.loadLocalKnowledge(
//           secondaryCategoryId: event.secondaryCategoryId,
//         );

//         log('Knowledge loaded successfully');
//         emit(KnowledgeSuccessState(
//           contents: result['contents'] as List<Map<String, dynamic>>,
//           extractPath: result['extractPath'] as String,
//           totalItems: result['totalItems'] as int,
//           isFromCache: true,
//           secondaryCategoryId: event.secondaryCategoryId,
//         ));
//       } catch (e) {
//         log('Error loading local knowledge: $e');
//         emit(KnowledgeFailureState(
//           errorMessage: 'Failed to load local knowledge: $e',
//         ));
//       }
//     });

//     // Download and extract knowledge (with force download option)
//     on<DownloadKnowledgeEvent>((event, emit) async {
//       try {
//         log('=== DOWNLOAD KNOWLEDGE EVENT ===');
//         log('Secondary Category ID: ${event.secondaryCategoryId}');
//         log('Primary Category ID: ${event.primaryCategoryId}');
//         log('Language ID: ${event.languageId}');
//         log('Force Download: ${event.forceDownload}');

//         // Check if already downloaded (unless force download)
//         if (!event.forceDownload) {
//           final exists = await repository.isKnowledgeDownloaded(
//             secondaryCategoryId: event.secondaryCategoryId,
//           );

//           if (exists) {
//             log('Knowledge already exists locally, loading from storage...');
//             // Load from local storage instead
//             final result = await repository.loadLocalKnowledge(
//               secondaryCategoryId: event.secondaryCategoryId,
//             );

//             emit(KnowledgeSuccessState(
//               contents: result['contents'] as List<Map<String, dynamic>>,
//               extractPath: result['extractPath'] as String,
//               totalItems: result['totalItems'] as int,
//               isFromCache: true,
//               secondaryCategoryId: event.secondaryCategoryId,
//             ));
//             return;
//           }
//         }

//         // Initial download state
//         emit(KnowledgeDownloadingState(progress: 0.0));

//         // Download and extract
//         final result = await repository.downloadAndExtractKnowledgeZip(
//           secondaryCategoryId: event.secondaryCategoryId,
//           primaryCategoryId: event.primaryCategoryId,
//           languageId: event.languageId,
//           forceDownload: event.forceDownload,
//           onProgress: (progress) {
//             log('Emitting progress: ${(progress * 100).toStringAsFixed(1)}%');
//             emit(KnowledgeDownloadingState(progress: progress));
//           },
//         );

//         // Emit extracting state briefly
//         emit(KnowledgeExtractingState());
//         await Future.delayed(const Duration(milliseconds: 500));

//         log('=== EMITTING SUCCESS STATE ===');
//         log('Contents count: ${result['contents'].length}');
//         log('Extract path: ${result['extractPath']}');

//         // Emit success state with category ID
//         emit(KnowledgeSuccessState(
//           contents: result['contents'] as List<Map<String, dynamic>>,
//           extractPath: result['extractPath'] as String,
//           totalItems: result['totalItems'] as int,
//           isFromCache: false,
//           secondaryCategoryId: event.secondaryCategoryId,
//         ));
//       } catch (e, stackTrace) {
//         log('=== BLOC ERROR ===');
//         log('Error: $e');
//         log('StackTrace: $stackTrace');
        
//         emit(KnowledgeFailureState(
//           errorMessage: 'Failed to download knowledge: $e',
//         ));
//       }
//     });
//   }
// }
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:langlex/domain/repository/app_repo.dart';

import 'package:langlex/presentation/blocs/knowledge_bloc/knowledge_event.dart';

part 'knowledge_state.dart';

class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {
  final AppRepo repository;

  KnowledgeBloc({required this.repository}) : super(KnowledgeInitial()) {
    // Single-check: does this category have local data?
    on<CheckLocalKnowledgeEvent>((event, emit) async {
      try {
        log('=== CHECKING LOCAL KNOWLEDGE (id=${event.secondaryCategoryId}) ===');
        emit(KnowledgeCheckingState());

        final exists = await repository.isKnowledgeDownloaded(
          secondaryCategoryId: event.secondaryCategoryId,
        );

        log('Knowledge exists locally: $exists');
        emit(KnowledgeExistsLocallyState(exists: exists));
      } catch (e) {
        log('Error checking local knowledge: $e');
        emit(KnowledgeFailureState(
          errorMessage: 'Failed to check local knowledge: $e',
        ));
      }
    });

    // Batch-check: prime UI with availability for many cards
    on<CheckMultipleKnowledgeStatusEvent>((event, emit) async {
      try {
        log('=== CHECKING MULTIPLE KNOWLEDGE STATUS ===');

        final Map<int, bool> statusMap = {};
        for (final categoryId in event.secondaryCategoryIds) {
          final exists = await repository.isKnowledgeDownloaded(
            secondaryCategoryId: categoryId,
          );
          statusMap[categoryId] = exists;
          log('Category $categoryId - Downloaded: $exists');
        }

        emit(KnowledgeMultipleStatusState(downloadStatus: statusMap));
      } catch (e) {
        log('Error checking multiple knowledge status: $e');
        emit(KnowledgeFailureState(
          errorMessage: 'Failed to check knowledge status: $e',
        ));
      }
    });

    // Load local knowledge for navigation (no dialogs, non-blocking)
    on<LoadLocalKnowledgeEvent>((event, emit) async {
      try {
        log('=== LOADING LOCAL KNOWLEDGE (id=${event.secondaryCategoryId}) ===');
        emit( KnowledgeLoadingState());

        final result = await repository.loadLocalKnowledge(
          secondaryCategoryId: event.secondaryCategoryId,
        );

        log('Knowledge loaded successfully: ${result['totalItems']} items');
        emit(KnowledgeSuccessState(
          contents: result['contents'] as List<Map<String, dynamic>>,
          extractPath: result['extractPath'] as String,
          totalItems: result['totalItems'] as int,
          isFromCache: true,
          secondaryCategoryId: event.secondaryCategoryId,
        ));
      } catch (e) {
        log('Error loading local knowledge: $e');
        emit(KnowledgeFailureState(
          errorMessage: 'Failed to load local knowledge: $e',
        ));
      }
    });

    // ❌ Removed: on<DownloadKnowledgeEvent> — download/progress handled by DownloadBloc
  }
}
