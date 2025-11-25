import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/edit_profilemodel.dart';
import 'package:langlex/data/models/profile_model.dart';

import 'package:langlex/data/models/verify_otp_model.dart';
import 'package:langlex/domain/token_inspector.dart';
import 'package:langlex/presentation/widgets/custom_sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class Loginrepo {
  final Dio dio;

  Loginrepo({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
                baseUrl: Endpoints.baseUrl,
                headers: {'Content-Type': 'application/json'}))..interceptors.add(TokenInterceptor());

  ///----------------------send otp-----------------------------////

  Future<ApiResponse<Map<String, String>>> sendOtp(
      {required mobileNumber}) async {
    try {
      Response response = await dio
          .post(Endpoints.sendOtp, data: {"mobileNumber": mobileNumber});
      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        final data = responseData["data"] ?? {};
        final user = data["user"];
        final userId =
            (user != null && user["id"] != null) ? user["id"].toString() : '';

        final customerType =
            responseData["data"]["customerType"]?.toString() ?? '';

        log(customerType.toString());
        return ApiResponse(
            data: {"userId": userId, "customerType": customerType},
            message: responseData["message"] ?? 'Success',
            error: false,
            status: responseData["status"]);
      } else {
        return ApiResponse(
            data: null,
            message: responseData["message"],
            error: true,
            status: responseData["status"]);
      }
    } on DioException catch (e) {
    if (e.response != null) {
      final responseData = e.response!.data;
      final statusCode = e.response!.statusCode ?? 500;

      return ApiResponse(
        data: null,
        message: responseData['message'] ?? 'Something went wrong',
        error: true,
        status: statusCode,
      );
    }
    debugPrint(e.message);
    log("kkkkkkkkkkkkkkkk");
    log(e.toString());

    return ApiResponse(
      data: null,
      message: 'Network or server error occurred',
      error: true,
      status: 500,
    );
    }
  }

  //////////------------verifyotp-----------/////////////////
  Future<ApiResponse<String>> verifyexistinguser(
      {required String userId, required String otp}) async {
    log(userId);
    log(otp);
    try {
      Response response =
          await dio.post(Endpoints.verifyotp, data: {"id": userId, "otp": otp});
      final responseData = response.data;
      // log('responsestatus${responseData["statusCode"]}');
      //log('usertoken${responseData["data"]["token"]}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final data = responseData["data"];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('USER_TOKEN', data["token"]);
        preferences.setString('USER_ID', data['user']['id']);
        return ApiResponse(
          data: data['user']['username'],
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
   
    if (e.response != null) {
      final responseData = e.response!.data;
      final statusCode = e.response!.statusCode ?? 500;

      return ApiResponse(
        data: null,
        message: responseData['message'] ?? 'Something went wrong',
        error: true,
        status: statusCode,
      );
    }
    debugPrint(e.message);
    log("kkkkkkkkkkkkkkkk");
    log(e.toString());

    return ApiResponse(
      data: null,
      message: 'Network or server error occurred',
      error: true,
      status: 500,
    );
    }
  }

  //////////------------verifyNewuser-----------/////////////////
  Future<ApiResponse> verifynewuser({required UserRegisterModel user}) async {
    try {
      Response response = await dio.post(Endpoints.userRegister, data: user);
      final responseData = response.data;
      log('responsestatus${responseData["status"]}');
      //log('usertoken${responseData["data"]["token"]}');
      log(responseData.toString());
      if (!responseData["error"] && responseData["status"] == 201) {
        final data = responseData["data"] ?? {};
        final user = data["user"];
        final userId =
            (user != null && user["id"] != null) ? user["id"].toString() : '';
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString('USER_TOKEN', responseData["token"]);
        return ApiResponse(
          data: userId,
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
    }
  }

//////////---------------resendotp--------------------////////
  Future<ApiResponse<String>> resendotp({required String mobilenumber}) async {
    try {
      Response response = await dio
          .post(Endpoints.resendotp, data: {"mobileNumber": mobilenumber});

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        final id = responseData["data"]["user"]["id"];
        return ApiResponse(
          data: id.toString(),
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
    if (e.response != null) {
      final responseData = e.response!.data;
      final statusCode = e.response!.statusCode ?? 500;

      return ApiResponse(
        data: null,
        message: responseData['message'] ?? 'Something went wrong',
        error: true,
        status: statusCode,
      );
    }
    debugPrint(e.message);
    log("kkkkkkkkkkkkkkkk");
    log(e.toString());

    return ApiResponse(
      data: null,
      message: 'Network or server error occurred',
      error: true,
      status: 500,
    );
    }
  }
/////////-------------fetchprofile---------/////////////
Future<ApiResponse<ProfileModel>> fetchprofile() async {
  try {
    final token = await getUserToken();

    // ✅ FIX: Add "Bearer " before token
    Response response = await dio.get(
      Endpoints.fetchprofile,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final responseData = response.data;
    log('profile status: ${responseData["status"]}');

    if (!responseData["error"] && responseData["status"] == 200) {
      final user = ProfileModel.fromJson(responseData["data"]);

      return ApiResponse(
        data: user,
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
    if (e.response != null) {
      final responseData = e.response!.data;
      final statusCode = e.response!.statusCode ?? 500;

      return ApiResponse(
        data: null,
        message: responseData['message'] ?? 'Something went wrong',
        error: true,
        status: statusCode,
      );
    }
    debugPrint(e.message);
    log("kkkkkkkkkkkkkkkk");
    log(e.toString());

    return ApiResponse(
      data: null,
      message: 'Network or server error occurred',
      error: true,
      status: 500,
    );
  } catch (e) {
    log("Unexpected error: $e");
    return ApiResponse(
      data: null,
      message: 'Unexpected error: $e',
      error: true,
      status: 500,
    );
  }
}


    ///////////---------------updateprofile----------/////////////
  Future<ApiResponse> updateprofiel({required EditProfileModel student}) async {
    try {
      final token = await getUserToken();

      // Create FormData from student model
      FormData formData = await student.toFormData();

      Response response = await dio.post(
        Endpoints.fetchprofile,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        }),
        data: formData,
      );

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
    if (e.response != null) {
      final responseData = e.response!.data;
      final statusCode = e.response!.statusCode ?? 500;

      return ApiResponse(
        data: null,
        message: responseData['message'] ?? 'Something went wrong',
        error: true,
        status: statusCode,
      );
    }
    debugPrint(e.message);
    log("kkkkkkkkkkkkkkkk");
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

  void dispose() {
    dio.close();
  }
}
