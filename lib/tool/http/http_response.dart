import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'http_exceptions.dart';

class HttpResponse {
  late bool ok;
  dynamic data;
  HttpException? error;

  HttpResponse._internal({this.ok = false});

  HttpResponse.success(this.data) {
    this.ok = true;
  }

  HttpResponse.failure({String? errorMsg, int? errorCode}) {
    this.error = BadRequestException(message: errorMsg, code: errorCode);
    this.ok = false;
    EasyLoading.showError(errorMsg ?? "");
  }

  HttpResponse.failureFormResponse({dynamic data}) {
    this.error = BadResponseException(data);
    this.ok = false;
    EasyLoading.showError(data ?? "");
  }

  HttpResponse.failureFromError([HttpException? error]) {
    this.error = error ?? UnknownException();
    this.ok = false;
    EasyLoading.showError(error?.message ?? "");
  }
}