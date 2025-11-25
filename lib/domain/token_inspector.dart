// import 'package:dio/dio.dart';
// import 'dart:developer';
// import 'session_manager.dart';

// class TokenInterceptor extends Interceptor {
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     try {
//       final responseData = response.data;
      
//       // Only check for expired token message
//       if (responseData is Map<String, dynamic>) {
//         final message = responseData['message']?.toString().toLowerCase() ?? '';
        
//         log('TokenInterceptor - Response message: $message');
        
//         // Check if message contains "expired token"
//         if (message.contains("jwt expired")) {
//           log('🔒 Expired token detected - triggering session handler');
//           SessionManager.handleExpiredToken(null);
          
//           // Reject the request to prevent further processing
//           handler.reject(
//             DioException(
//               requestOptions: response.requestOptions,
//               response: response,
//               type: DioExceptionType.badResponse,
//               error: "jwt expired",
//             ),
//           );
//           return;
//         }
//       }
//     } catch (e) {
//       log('Error in TokenInterceptor: $e');
//     }
    
//     super.onResponse(response, handler);
//   }
// }
////////////////////////
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'session_manager.dart';

class TokenInterceptor extends Interceptor {
  // helper to extract lower-cased message text safely
  String _extractMessage(dynamic data) {
    try {
      if (data == null) return '';
      if (data is String) {
        // if it's JSON string try to parse
        try {
          final decoded = json.decode(data);
          if (decoded is Map && decoded['message'] != null) {
            return decoded['message'].toString().toLowerCase();
          }
        } catch (_) {
          return data.toLowerCase();
        }
        return data.toLowerCase();
      }
      if (data is Map<String, dynamic>) {
        return (data['message'] ?? data['error'] ?? '').toString().toLowerCase();
      }
      return data.toString().toLowerCase();
    } catch (e) {
      log('TokenInterceptor._extractMessage error: $e');
      return '';
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final message = _extractMessage(response.data);
      log('TokenInterceptor.onResponse message: $message, status: ${response.statusCode}');
      if (message.contains('jwt expired') ) {
        log('TokenInterceptor - detected expired token in onResponse');
        SessionManager.handleExpiredToken(null);
        // reject so caller receives an error instead of success
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: 'jwt expired',
          ),
        );
        return;
      }
    } catch (e) {
      log('TokenInterceptor onResponse error: $e');
    }
    super.onResponse(response, handler); // continue normal flow
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final resp = err.response;
      final message = _extractMessage(resp?.data);
      log('TokenInterceptor.onError status: ${resp?.statusCode}, message: $message, error: ${err.error}');

      // common pattern: server returns 401 for expired tokens
      if (resp?.statusCode == 401 ||
          message.contains('jwt expired') ||
          message.contains('token expired') ||
          message.contains('expired token')) {
        log('TokenInterceptor - detected expired token in onError');
        SessionManager.handleExpiredToken(null);
        // Optionally reject with a clearer error
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            response: resp,
            type: DioExceptionType.badResponse,
            error: 'jwt expired',
          ),
        );
        return;
      }
    } catch (e) {
      log('TokenInterceptor onError handling error: $e');
    }

    super.onError(err, handler); // default error propagation
  }
}
