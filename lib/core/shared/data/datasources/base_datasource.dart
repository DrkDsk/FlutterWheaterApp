import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:dio/dio.dart';

abstract class BaseDataSource {
  Future<T> safeRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on NoInternetException {
      rethrow;
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    } catch (e) {
      throw UnknownException();
    }
  }
}
