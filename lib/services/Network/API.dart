import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:heroself/Chat/controller/chatController.dart';

import '../../utils/loader.dart';
import 'Url.dart';
import 'interceptor.dart';

final String baseUrl = Environment().config!.baseUrl;
final String apiUrl = Environment().config!.apiUrl;
final String imageUrl = Environment().config!.imageUrl;
final String socketUrl = Environment().config!.socketUrl;
class Api {
  static final Api singleton = Api._internal();
  factory Api() {
    return singleton;
  }

  Api._internal();

  var sp = GetStorage();

  ///---------Toggle Static \ Dynamic--------///

  // String appType = "Static";
  String appType = "Dynamic";

  ///---------Toggle Static \ Dynamic End--------///
  Future<dynamic> interceptorGet(String url,
      {fullUrl, queryParameters, firstTime = false}) async {
    Dio dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
          requestRetry: DioConnectivityRequestRetry(
            dio: dio,
            connectivity: Connectivity(),
          ),
          firstTime: firstTime),
    );
    dio.options.headers['Authorization'] = "Bearer ${sp.read('token')}";
    if (fullUrl != null) {
      if (fullUrl.contains("http://123.223.229.217/api/")) {
        fullUrl = fullUrl.replaceFirst("http://123.223.229.217/api/",
            "http://123.223.229.217/hero-self/api/");
      }
    }
    if (url != "") {
      try {
        final response = await dio.get(fullUrl ?? apiUrl + url,
            queryParameters: queryParameters);
        return response;
      } on SocketException {
        BotToast.showText(text: 'No Internet connection');
      } on DioError catch (e) {
        return returnResponse(e.response!);
      }
    }
  }

  Future<dynamic> interceptorPost(
    formData,
    url, {
    fullUrl,
    queryParameters,
    firstTime = false,
    auth = false,
    multiPart = false,
    nonFormContent = false,
    isProgressShow = false,
    bool video = false,
    int? rand,
  }) async {
    Dio dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
          requestRetry: DioConnectivityRequestRetry(
            dio: dio,
            connectivity: Connectivity(),
          ),
          firstTime: firstTime),
    );
    dio.options.headers['Authorization'] = "Bearer ${sp.read('token')}";
    if (fullUrl != null) {
      if (fullUrl.contains("http://123.223.229.217/api/")) {
        fullUrl = fullUrl.replaceFirst("http://123.223.229.217/api/",
            "http://123.223.229.217/hero-self/api/");
      }
    }
    if (url != "") {
      try {
        dynamic response = await dio.post(
          fullUrl ?? apiUrl + url,
          data: formData,
          options: multiPart == true
              ? Options(
                  headers: {
                    Headers.acceptHeader: "application/json",
                  },
                  contentType: 'multipart/form-data',
                )
              : Options(
                  headers: {
                      Headers.acceptHeader: "application/json",
                    },
                  contentType: nonFormContent == false
                      ? null
                      : "application/x-www-form-urlencoded"),
          // queryParameters: queryPerameter
          // onSendProgress: video == true
          //     ? (int sent, int total) {
          //   onProgress(video, rand, total, sent, fullUrl, fromChat: true);
          // }
          //     : null,
        );
        return response;
      } on SocketException {
        BotToast.showText(text: 'No Internet connection');
      } on DioError catch (e) {
        return returnResponse(e.response!);
      }
    }
  }

  Future<dynamic> get(String url, {fullUrl, queryParameters, nextUrl}) async {
    Dio dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));

    print('Api Get, url ${apiUrl + url}');
    var headers = {'token': '${sp.read('token')}'};
    print(sp.read('token'));
    dio.options.headers.addAll(headers);

    if (url != "") {
      try {
        final response = await dio.get(fullUrl ?? apiUrl + url,
            queryParameters: queryParameters);
        print("url ComBined : $apiUrl$url");
        return response;
      } on SocketException {
        BotToast.showText(text: 'No Internet connection');
      } on DioError catch (e) {
        return returnResponse(e.response);
      }
    }
  }

  Future<dynamic> delete(formData, String url, {isProgressShow = false}) async {
    if (isProgressShow == false) {
      BotToast.showLoading();
    }
    Dio dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));
    dio.options.headers['Authorization'] = "Bearer ${sp.read('token')}";

    try {
      final response = await dio.post(
        apiUrl + url,
        data: formData,
        options: Options(
          headers: {
            Headers.acceptHeader: "application/json",
          },
        ),
      );
      Future.delayed(Duration(seconds: 1), () {
        if (isProgressShow == false) {
          BotToast.closeAllLoading();
        }
      });
      return response;
    } on SocketException {
      Future.delayed(Duration(seconds: 1), () {
        if (isProgressShow == false) {
          BotToast.closeAllLoading();
        }
      });
      BotToast.showText(text: 'No Internet connection');
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        BotToast.closeAllLoading();
        BotToast.showText(text: "Connection Timeout Exception");
        throw Exception("Connection Timeout Exception");
      }
      Future.delayed(Duration(seconds: 1), () {
        if (isProgressShow == false) {
          BotToast.closeAllLoading();
        }
      });
      return returnResponse(e.response!);
    }
  }

  Future<dynamic> post(formData, url,
      {auth = false,
      multiPart = false,
      nonFormContent = false,
      isProgressShow = false,
      bool video = false,
      int? rand,
      fullUrl,
      Map<String, dynamic>? queryPerameter}) async {
    if (isProgressShow == false) {
      showLoading();
    }

    Dio dio = Dio();
    if (auth == false) {
      print(sp.read('token'));
      var headers = {'token': '${sp.read('token')}'};
      // dio.options.headers['Authorization'] = "${sp.read('token')}";
      dio.options.headers.addAll(headers);
    }

    try {
      print("Data here Parameter: ${formData}");
      dynamic response = await dio.post(fullUrl ?? apiUrl + url,
          data: formData,
          options: multiPart == true
              ? Options(
                  headers: {
                    Headers.acceptHeader: "application/json",
                  },
                  contentType: 'multipart/form-data',
                )
              : Options(
                  headers: {
                      Headers.acceptHeader: "application/json",
                    },
                  contentType: nonFormContent == false
                      ? null
                      : "application/x-www-form-urlencoded"),
          queryParameters: queryPerameter
          // onSendProgress: video == true
          //     ? (int sent, int total) {
          //   onProgress(video, rand, total, sent, fullUrl, fromChat: true);
          // }
          //     : null,
          );
      if (isProgressShow == false) {
        BotToast.closeAllLoading();
      }
      print("url ComBined Post : $apiUrl$url");
      return response;
    } on DioError catch (e) {
      if (isProgressShow == false) {
        BotToast.closeAllLoading();
      }

      if (e.type == DioErrorType.connectionError) {
        BotToast.showText(text: 'No Internet connection');
      }
      return returnResponse(e.response);
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      print("error $e");
    }
  }


  dynamic returnResponse(Response? response) {
    BotToast.closeAllLoading();
    if (response != null) {
      switch (response.statusCode) {
        case 200:
          var responseJson = json.decode(response.data.toString());
          print(responseJson);
          return responseJson;
        case 400:
          BotToast.showText(text: response.data["message"].toString());
          return response;
        case 401:
          BotToast.showText(text: response.data["message"].toString());
          return response;
        case 409:
          BotToast.showText(text: response.data["message"].toString());
          return response;
        case 410:
          BotToast.showText(text: response.data["message"].toString());
          return response;
        case 404:
          BotToast.showText(text: response.data["message"].toString());
          return response;
        case 403:
          BotToast.showText(text: response.data["message"].toString());
          return response;
        case 301:
          BotToast.showText(text: response.data["message"].toString());
          return response;
        case 500:
          BotToast.showText(text: 'Server not responding');
          return response;
        default:
          BotToast.showText(
              text:
                  'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
          return response;
      }
    }
    BotToast.showText(text: 'Connection Error');
    throw SocketException("No Internet");
  }

  Future<void> deleteAllKeysExceptOne(String keyToKeep) async {
    GetStorage storage = GetStorage();
    List<String> allKeys = storage.getKeys().toList();

    for (String key in allKeys) {
      if (key != keyToKeep) {
        await storage.remove(key);
      }
    }
  }
}
