import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/language_model.dart';
import 'package:langlex/data/models/student_list_model.dart';
import 'package:langlex/data/models/student_model.dart';
import 'package:langlex/presentation/widgets/custom_sharedpreferences.dart';

class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse(
      {this.data,
      required this.message,
      required this.error,
      required this.status});
}

class AppRepo {
  final Dio dio;
  AppRepo({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
                baseUrl: Endpoints.baseUrl,
                headers: {'content-Type': 'application/json'}));
///////------------------fetchlanguages-------------//////////////////////
  Future<ApiResponse<List<LanguageModel>>> fetchlanguages() async {
    try {
      Response response = await dio.get(Endpoints.fetchlanguages);
      final responseData = response.data;
      log(responseData['error'].toString());
      if (!responseData['error'] && responseData['status'] == 200) {
        log(responseData['status'].toString());
        final List<dynamic> languagelists = responseData['data'];
        List<LanguageModel> languages = languagelists
            .map((language) => LanguageModel.fromJson(language))
            .toList();
        log(languages[0].toString());
        return ApiResponse(
            data: languages,
            message: responseData['message'] ?? 'Success',
            error: false,
            status: responseData['status']);
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  ///////////---------------registerStudent----------/////////////
  Future<ApiResponse> registerStudent(
      {required StudentModel student}) async {
    try {
      final token = await getUserToken();

      Response response = await dio.post(Endpoints.registerstudent,
          options: Options(headers: {'Authorization': token}), data:student);

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    } catch (e) {
      // Add a general catch block for other exceptions
      log("Unexpected error: $e");
      return ApiResponse(
        data: null,
        message: 'Unexpected error: $e',
        error: true,
        status: 500,
      );
    }
  }
  /////////////------------fetchStudentList-------------//////////////////
    Future<ApiResponse<List<StudentListModel>>> fetchkidsList() async {
    try {
      Response response = await dio.get(Endpoints.fetchlanguages);
      final responseData = response.data;
      log(responseData['error'].toString());
      if (!responseData['error'] && responseData['status'] == 200) {
        log(responseData['status'].toString());
        final List<dynamic> studenlists = responseData['data'];
        List<StudentListModel> students = studenlists
            .map((language) => StudentListModel.fromJson(language))
            .toList();
    
        return ApiResponse(
            data:students,
            message: responseData['message'] ?? 'Success',
            error: false,
            status: responseData['status']);
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  void dispose() {
    dio.close();
  }
}
