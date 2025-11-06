import 'package:clima_app/core/error/exceptions/model_exception.dart';
import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/extensions/dio/dio_extension.dart';
import 'package:dio/dio.dart';

abstract class BaseDataSource {
  Future<T> safeRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on NoInternetException {
      rethrow;
    } on DioException catch (e) {
      throw NetworkException(e.userFriendlyMessage);
    } on ModelException catch (e) {
      throw UnknownException(message: e.message);
    } catch (e) {
      throw UnknownException();
    }
  }
}
