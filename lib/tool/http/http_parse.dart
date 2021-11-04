// 成功回调

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:yizz_plugin/tool/http/http_response.dart';
import 'http_exceptions.dart';
import 'http_transformer.dart';

HttpResponse<T> handleResponse<T>(Response? response,
    {HttpTransformer? httpTransformer}) {

  // 返回值异常
  if (response == null) {
    return HttpResponse.failureFromError();
  }

  // token失效
  if (_isTokenTimeout(response.statusCode)) {
    return HttpResponse.failureFromError(
        UnauthorisedException(message: "没有权限", code: response.statusCode.toString()));
  }
  // 接口调用成功
  if (_isRequestSuccess(response.statusCode)) {
    return httpTransformer!.parse<T>(response);
  } else {
    // 接口调用失败
    return HttpResponse.failure(
        errorMsg: response.statusMessage, errorCode: '${response.statusCode}');
  }
}

HttpResponse<T> handleException<T>(Exception exception) {
  var parseException = _parseException(exception);
  return HttpResponse<T>.failureFromError(parseException);
}

/// 鉴权失败
bool _isTokenTimeout(int? code) {
  return code == 401;
}

/// 请求成功
bool _isRequestSuccess(int? statusCode) {
  return (statusCode != null && statusCode >= 200 && statusCode < 300);
}

HttpException _parseException(Exception error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return NetworkException(message: error.message);
      case DioErrorType.cancel:
        return CancelException(error.message);
      case DioErrorType.response:
        try {
          String? errCode = error.response?.statusCode.toString();
          switch (errCode) {
            case '400':
              return BadRequestException(message: "请求语法错误", code: errCode);
            case '401':
              return UnauthorisedException(message: "没有权限", code: errCode);
            case '403':
              return BadRequestException(message: "服务器拒绝执行", code: errCode);
            case '404':
              return BadRequestException(message: "无法连接服务器", code: errCode);
            case '405':
              return BadRequestException(message: "请求方法被禁止", code: errCode);
            case '500':
              return BadServiceException(message: "服务器内部错误", code: errCode);
            case '502':
              return BadServiceException(message: "无效的请求", code: errCode);
            case '503':
              return BadServiceException(message: "服务器挂了", code: errCode);
            case '505':
              return UnauthorisedException(
                  message: "不支持HTTP协议请求", code: errCode);
            default:
              return UnknownException(error.message);
          }
        } on Exception catch (_) {
          return UnknownException(error.message);
        }

      case DioErrorType.other:
        if (error.error is SocketException) {
          return NetworkException(message: error.message);
        } else {
          return UnknownException(error.message);
        }
      default:
        return UnknownException(error.message);
    }
  } else {
    return UnknownException(error.toString());
  }
}