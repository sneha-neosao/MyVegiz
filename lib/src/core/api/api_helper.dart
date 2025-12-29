import 'dart:io';
import 'package:dio/dio.dart';
import '../utils/logger.dart';
import 'api_exception.dart';

/// A helper class to handle API requests using [Dio].
class ApiHelper {
  final Dio _dio;

  /// Creates an instance of [ApiHelper] with a given Dio client.
  const ApiHelper(this._dio);

  Future<Map<String, dynamic>> execute({
    required Method method,
    required String url,
    dynamic data,
    dynamic options,
  }) async {
    try {
      Response? response;

      logger.d(url);
      logger.d(method);
      logger.d(data);

      /// Choose HTTP method dynamically
      switch (method) {
        case Method.get:
          response = await _dio.get(url,data:data,options: options??Options());
          break;
        case Method.post:
          response = await _dio.post(url, data: data, options: options??Options());
          break;
        case Method.put:
          response = await _dio.put(url, data: data, options: options??Options());
          break;
        case Method.patch:
          response = await _dio.patch(url, data: data, options: options??Options());
          break;
        case Method.delete:
          response = await _dio.delete(url, data: data, options: options??Options()); // Dio supports body in DELETE
          break;
      }
      logger.d(response);
      return _returnResponse(response);
    } on SocketException {
      /// No internet or connection issue
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      logger.e(e.message);
      return _returnResponse(e.response!);
    }
  }

  /// Handles and converts Dio [Response] into a [Map<String, dynamic>]
  /// or throws the correct [ApiException] based on the status code.
  Map<String, dynamic> _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data["message"].toString());
      case 401:
        throw UnauthorizedException(response.data["message"].toString());
      case 403:
        throw ForbiddenException(response.data["message"].toString());
      case 404:
        throw NotFoundException(response.data["message"].toString());
      case 422:
        throw UnprocessableContentException(
            response.data["message"].toString());
      case 500:
        throw InternalServerException(response.data["message"].toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

enum Method { get, post, put, patch, delete }
