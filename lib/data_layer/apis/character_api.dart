import 'dart:developer';

import 'package:bloc_pattern_project/constants/constants.dart';
import 'package:dio/dio.dart';

class CharacterApi {
  late Dio dio;

  CharacterApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }


   /// TODO : Get All Characters Data
  Future<List<dynamic>> getAllCharacters() async {
    try {
      final response = await dio.get('characters');
      return response.data;
    } catch (e) {
      log('error' + e.toString());
      return [];
    }
  }

  /// TODO : Get All Quotes Data
  Future<List<dynamic>> getQuotes(String charName) async {
    try {
      final response = await dio.get('quote' , queryParameters: {'author': charName},);
      return response.data;
    } catch (e) {
      log('error' + e.toString());
      return [];
    }
  }

}
