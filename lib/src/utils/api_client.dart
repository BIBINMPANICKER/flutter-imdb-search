import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class ApiClient {
  ApiClient() {
    initClient();
  }

  final String baseUrl = 'https://api.themoviedb.org/3';

  Dio _dio;

  //  Options _options;
  BaseOptions _baseOptions;

  initClient() async {
    _baseOptions = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 1000000,
        contentType: ContentType.json,
        followRedirects: true,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          'x-rapidapi-key': 'e49dbf2819msh2f4cdbf2e5fa4f3p116064jsn32f7bd7fd532'
        },
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true);

    _dio = new Dio(_baseOptions);

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    _dio.interceptors.add(CookieManager(new CookieJar()));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions reqOptions) {
        return reqOptions;
      },
      onError: (DioError dioError) {
        return dioError.response;
      },
    ));
  }

  Dio get dio => _dio;

  ///=====================================================
  ///
  /// ====================================================

  //get movie
  Future<Response> getMovies(String movieName) {
    return _dio.get("/search/movie?api_key=d5b098de718ad270af9e1c51df9bb6df"
        "&query=$movieName&page=1");
  }
}
