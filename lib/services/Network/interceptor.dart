// ignore_for_file: invalid_required_positional_param, unrelated_type_equality_checks, use_rethrow_when_possible, empty_constructor_bodies

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../utils/loader.dart';
import 'API.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetry requestRetry;
  bool error = false;
  bool firstTime;

  RetryOnConnectionChangeInterceptor(
      {required this.requestRetry, this.firstTime = false});

  @override
  Future onError(DioError err, handler) async {
    // TODO: implement onError
    if (_shouldRetry(err, firstTime: firstTime)) {
      try {
        if (err.response == null) {
          return requestRetry.scheduleRequestRetry(err, handler);
        }
      } catch (e) {
        return super.onError(err, handler);
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err, {firstTime}) {
    if (err.type == DioErrorType.connectionError ||
        err.type == DioErrorType.unknown) {
      if (error == false) {
        error = true;
        if (firstTime == true) {
          showLoading();
        }
        BotToast.showText(text: 'Internet Error !! Retrying');
        // Future.delayed(Duration(seconds: 8), () {
        //   error = false;
        // });
      }
      return true;
    } else {
      if (err.type == DioErrorType.connectionTimeout) {
        BotToast.closeAllLoading();
        return Api.singleton.returnResponse(err.response);
      }
      if (err.type == DioErrorType.receiveTimeout) {
        BotToast.closeAllLoading();
        return Api.singleton.returnResponse(err.response);
      }
      print("error response is ${err.response!.requestOptions.path}");
      BotToast.closeAllLoading();
      return Api.singleton.returnResponse(err.response);
    }
  }
}

class DioConnectivityRequestRetry {
  final Dio? dio;
  final Connectivity? connectivity;

  DioConnectivityRequestRetry({
    required this.dio,
    required this.connectivity,
  });

  void scheduleRequestRetry(DioError error, ErrorInterceptorHandler handler) {
    late StreamSubscription streamSubscription;
    streamSubscription = connectivity!.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          try {
            var response = await dio!.fetch(error.requestOptions);
            handler.resolve(response);
          } on DioError catch (retryError) {
            handler.next(retryError);
          }
        }
      },
    );
  }
}
