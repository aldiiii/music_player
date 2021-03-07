import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:music_player/configs/constants/api_url.dart';

abstract class HttpClient {
  Future<dynamic> get(String url,
      {Map<String, dynamic> headers,
      Map<String, dynamic> queryParameters,
      bool authorization = false});
  Future<dynamic> post(String url,
      {Map headers, @required body, bool authorization = false});
  Future<dynamic> put(String url,
      {Map headers, @required body, bool authorization = false});
}

class HttpClientImpl implements HttpClient {
  final Dio _dio;

  HttpClientImpl(this._dio) {
    _initApiClient();
  }

  void _initApiClient() {
    _dio..options.baseUrl = API.BASE_API;
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (RequestOptions options) async {
    //       if (options.queryParameters != null) {
    //         print("queryParameters:");
    //         options.queryParameters.forEach((k, v) => print('$k: $v'));
    //       }
    //       return options;
    //     },
    //     onResponse: (Response response) async {
    //       print(
    //           "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    //       print("Response: ${response.data}");
    //       print("<-- END HTTP");
    //       /// do logic

    //       return response;
    //     },
    //     onError: (DioError e) async {
    //       /// do logic

    //       return e;
    //     },
    //   ),
    // );
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    bool authorization = false,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      final String res = json.encode(response.data);
      print('[API Dio Helper - GET] Server Response: $res');

      return response.data;
    } on DioError catch (e) {
      // print('[API Dio Helper - GET] Connection Exception => ' + e.message);

      if (e?.response?.data != null) throw Exception(e.response.data);

      throw Exception(e.message);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Map headers,
    @required body,
    bool authorization = false,
  }) async {
    try {
      print('[API Dio Helper - POST] Server Request: $body');

      final response =
          await _dio.post(url, data: body, options: Options(headers: headers));

      final String res = json.encode(response.data);
      print('[API Dio Helper - POST] Server Response: ' + res);

      return response.data;
    } on DioError catch (e) {
      print('[API Dio Helper - POST] Connection Exception => ' + e.message);

      // if (e.response.statusCode == 401) {
      //   Modular.to.pushReplacementNamed(Routers.userLogin);
      // }

      throw Exception(e.message);
    }
  }

  @override
  Future put(
    String url, {
    Map headers,
    @required body,
    bool authorization = false,
  }) async {
    try {
      print('[API Dio Helper - POST] Server Request: $body');

      final response =
          await _dio.put(url, data: body, options: Options(headers: headers));

      final String res = json.encode(response.data);
      print('[API Dio Helper - POST] Server Response: ' + res);

      return response.data;
    } on DioError catch (e) {
      print('[API Dio Helper - POST] Connection Exception => ' + e.message);

      throw Exception(e.message);
    }
  }
}
