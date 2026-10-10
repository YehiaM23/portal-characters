import 'package:dio/dio.dart';
import 'package:project1/constants/strings.dart';

class CharachterWebServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  Future<List<dynamic>> getAllCharachters({int page = 1}) async {
    final response = await dio.get(
      'character',
      queryParameters: {'page': page},
    );
    return response.data['results'] as List<dynamic>;
  }
}
