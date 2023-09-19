import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../components/utils/utils.dart';
import '../constants/app_constants.dart';
import '../constants/duration_constants.dart';
import 'base_model.dart';

class BaseService {
  late Dio dio;

  BaseService() {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      receiveDataWhenStatusError: true,
      headers: {"Content-Type": "application/json"},
      connectTimeout:
          const Duration(seconds: DurationConstants.tenSeconds), //* 10 seconds
      receiveTimeout:
          const Duration(seconds: DurationConstants.tenSeconds), //* 10 seconds
    ))
        /*   ..interceptors.add(LogInterceptor(
          responseBody: true, requestBody: true, responseHeader: false))*/
        ;
  }

  Future<dynamic> get<T extends IBaseModel>(String path,
      {required IBaseModel model, Map<String, dynamic>? parameters}) async {
    try {
      final response = await dio.get(path, queryParameters: parameters);
      switch (response.statusCode) {
        case HttpStatus.ok:
          return _jsonBodyParser<T>(model, response.data);
        default:
          throw response.data;
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          log(e.toString());
          Utils.instance.showCustomSnackbar("Error", "There is an error",
              snackbarType: SnackbarType.error);
          break;
        case DioExceptionType.connectionTimeout:
          Utils.instance.showCustomSnackbar("C Timeout", "Timeout error",
              snackbarType: SnackbarType.error);
          break;
        case DioExceptionType.receiveTimeout:
          Utils.instance.showCustomSnackbar("R Timeout", "Timeout error",
              snackbarType: SnackbarType.error);
          break;
        default:
      }
    }
  }

  Future<dynamic> post<T extends IBaseModel>(String path,
      {required IBaseModel requestModel,
      required IBaseModel responseModel,
      Map<String, dynamic>? parameters}) async {
    try {
      final response = await dio.post(path,
          data: requestModel.toJson(), queryParameters: parameters);
      switch (response.statusCode) {
        case HttpStatus.ok:
          return _jsonBodyParser<T>(responseModel, response.data);
        case HttpStatus.notFound:
          log("Not found ${response.data}");
          break;
        default:
          throw response.data;
      }
    } on DioException catch (e) {
      //todo: change them, create a class
      switch (e.type) {
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 401) {
            //*auth error
            Utils.instance.showCustomSnackbar("Auth error", "Auth error",
                snackbarType: SnackbarType.error);
          } /*else {
            Utils.instance.showCustomSnackbar(LocaleKeys.response_fail.tr(),
                BaseResponseModel.fromJson(e.response!.data).message!,
                snackbarType: SnackbarType.error);
          }*/
          log(e.toString());
          Utils.instance.showCustomSnackbar("Error", e.response?.data ?? "",
              snackbarType: SnackbarType.error);
          break;
        case DioExceptionType.connectionTimeout:
          Utils.instance.showCustomSnackbar("C Timeout", "Timeout error",
              snackbarType: SnackbarType.error);
          break;
        case DioExceptionType.receiveTimeout:
          Utils.instance.showCustomSnackbar("R Timeout", "Timeout error",
              snackbarType: SnackbarType.error);
          break;
        default:
      }
    }
  }

  dynamic _jsonBodyParser<T>(IBaseModel model, dynamic body) {
    final jsonBody = jsonDecode(jsonEncode(body));
    //log("After decoding\n ${jsonBody.toString()}");
    if (jsonBody is List) {
      return jsonBody.map((e) => model.fromJson(e)).toList().cast<T>();
    } else if (jsonBody is Map) {
      return model.fromJson(jsonBody as Map<String, dynamic>);
    } else {
      //* for string response
      return jsonBody;
    }
  }
}
