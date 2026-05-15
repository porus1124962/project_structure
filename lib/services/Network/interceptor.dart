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
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err, firstTime: firstTime)) {
      try {
        if (err.response == null) {
          requestRetry.scheduleRequestRetry(err, handler);
          return;
        }
      } catch (_) {
        handler.next(err);
        return;
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err, {firstTime}) {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      if (!error) {
        error = true;
        if (firstTime == true) showLoading();
        BotToast.showText(text: 'Internet Error !! Retrying');
      }
      return true;
    }

    // Non-retryable — show feedback and let the caller handle the response.
    if (err.type == DioExceptionType.connectionTimeout) {
      BotToast.closeAllLoading();
      BotToast.showText(text: 'Connection timed out');
    } else if (err.type == DioExceptionType.receiveTimeout) {
      BotToast.closeAllLoading();
      BotToast.showText(text: 'Server took too long to respond');
    } else {
      BotToast.closeAllLoading();
      Api.singleton.returnResponse(err.response);
    }
    return false;
  }
}

class DioConnectivityRequestRetry {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetry({
    required this.dio,
    required this.connectivity,
  });

  void scheduleRequestRetry(DioException error, ErrorInterceptorHandler handler) {
    late StreamSubscription<List<ConnectivityResult>> streamSubscription;
    streamSubscription = connectivity.onConnectivityChanged.listen(
      (results) async {
        final hasConnection = results.any((r) =>
            r == ConnectivityResult.wifi || r == ConnectivityResult.mobile);
        if (hasConnection) {
          streamSubscription.cancel();
          try {
            final response = await dio.fetch(error.requestOptions);
            handler.resolve(response);
          } on DioException catch (retryError) {
            handler.next(retryError);
          }
        }
      },
    );
  }
}
