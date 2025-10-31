// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:langlex/domain/repository/app_repo.dart';
// import 'package:meta/meta.dart';

// part 'knowledge_event.dart';
// part 'knowledge_state.dart';

// class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {
//   final AppRepo repository; // AppRepo instance

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

//     // Load local knowledge
//     on<LoadLocalKnowledgeEvent>((event, emit) async {
//       try {
//         log('=== LOADING LOCAL KNOWLEDGE ===');
//         emit(KnowledgeDownloadingState(progress: 1.0));
        
//         final result = await repository.loadLocalKnowledge(
//           secondaryCategoryId: event.secondaryCategoryId,
//         );

//         log('Knowledge loaded successfully');
//         emit(KnowledgeSuccessState(
//           contents: result['contents'] as List<Map<String, dynamic>>,
//           extractPath: result['extractPath'] as String,
//           totalItems: result['totalItems'] as int,
//         ));
//       } catch (e) {
//         log('Error loading local knowledge: $e');
//         emit(KnowledgeFailureState(
//           errorMessage: 'Failed to load local knowledge: $e',
//         ));
//       }
//     });

//     // Download and extract knowledge
//     on<DownloadKnowledgeEvent>((event, emit) async {
//       try {
//         log('=== DOWNLOAD KNOWLEDGE EVENT ===');
//         log('Secondary Category ID: ${event.secondaryCategoryId}');
//         log('Primary Category ID: ${event.primaryCategoryId}');
//         log('Language ID: ${event.languageId}');

//         // Initial download state
//         emit(KnowledgeDownloadingState(progress: 0.0));

//         // Download and extract
//         final result = await repository.downloadAndExtractKnowledgeZip(
//           secondaryCategoryId: event.secondaryCategoryId,
//           primaryCategoryId: event.primaryCategoryId,
//           languageId: event.languageId,
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

//         // Emit success state
//         emit(KnowledgeSuccessState(
//           contents: result['contents'] as List<Map<String, dynamic>>,
//           extractPath: result['extractPath'] as String,
//           totalItems: result['totalItems'] as int,
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
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'knowledge_event.dart';
part 'knowledge_state.dart';

class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {
  final AppRepo repository;

  KnowledgeBloc({required this.repository}) : super(KnowledgeInitial()) {
    
    // Check if knowledge exists locally
    on<CheckLocalKnowledgeEvent>((event, emit) async {
      try {
        log('=== CHECKING LOCAL KNOWLEDGE ===');
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

    // Load local knowledge
    on<LoadLocalKnowledgeEvent>((event, emit) async {
      try {
        log('=== LOADING LOCAL KNOWLEDGE ===');
        emit(KnowledgeLoadingState());
        
        final result = await repository.loadLocalKnowledge(
          secondaryCategoryId: event.secondaryCategoryId,
        );

        log('Knowledge loaded successfully');
        emit(KnowledgeSuccessState(
          contents: result['contents'] as List<Map<String, dynamic>>,
          extractPath: result['extractPath'] as String,
          totalItems: result['totalItems'] as int,
        ));
      } catch (e) {
        log('Error loading local knowledge: $e');
        emit(KnowledgeFailureState(
          errorMessage: 'Failed to load local knowledge: $e',
        ));
      }
    });

    // Download and extract knowledge (with force download option)
    on<DownloadKnowledgeEvent>((event, emit) async {
      try {
        log('=== DOWNLOAD KNOWLEDGE EVENT ===');
        log('Secondary Category ID: ${event.secondaryCategoryId}');
        log('Primary Category ID: ${event.primaryCategoryId}');
        log('Language ID: ${event.languageId}');
        log('Force Download: ${event.forceDownload}');

        // Check if already downloaded (unless force download)
        if (!event.forceDownload) {
          final exists = await repository.isKnowledgeDownloaded(
            secondaryCategoryId: event.secondaryCategoryId,
          );

          if (exists) {
            log('Knowledge already exists locally, loading from storage...');
            // Load from local storage instead
            final result = await repository.loadLocalKnowledge(
              secondaryCategoryId: event.secondaryCategoryId,
            );

            emit(KnowledgeSuccessState(
              contents: result['contents'] as List<Map<String, dynamic>>,
              extractPath: result['extractPath'] as String,
              totalItems: result['totalItems'] as int,
              isFromCache: true, // Flag to show it's from cache
            ));
            return;
          }
        }

        // Initial download state
        emit(KnowledgeDownloadingState(progress: 0.0));

        // Download and extract (this will download to a temporary location first)
        final result = await repository.downloadAndExtractKnowledgeZip(
          secondaryCategoryId: event.secondaryCategoryId,
          primaryCategoryId: event.primaryCategoryId,
          languageId: event.languageId,
          forceDownload: event.forceDownload,
          onProgress: (progress) {
            log('Emitting progress: ${(progress * 100).toStringAsFixed(1)}%');
            emit(KnowledgeDownloadingState(progress: progress));
          },
        );

        // Emit extracting state briefly
        emit(KnowledgeExtractingState());
        await Future.delayed(const Duration(milliseconds: 500));

        log('=== EMITTING SUCCESS STATE ===');
        log('Contents count: ${result['contents'].length}');
        log('Extract path: ${result['extractPath']}');

        // Emit success state
        emit(KnowledgeSuccessState(
          contents: result['contents'] as List<Map<String, dynamic>>,
          extractPath: result['extractPath'] as String,
          totalItems: result['totalItems'] as int,
          isFromCache: false,
        ));
      } catch (e, stackTrace) {
        log('=== BLOC ERROR ===');
        log('Error: $e');
        log('StackTrace: $stackTrace');
        
        emit(KnowledgeFailureState(
          errorMessage: 'Failed to download knowledge: $e',
        ));
      }
    });
  }
}