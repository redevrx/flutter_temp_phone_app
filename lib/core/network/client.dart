import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class Client {
  static final _instance = Client._();

  Client._();

  factory Client() => _instance;

  static const mUrl = "https://api.temp-phone-number.org/";
  static const timeOut = Duration(seconds: 1);
  static final HttpClient _sharedHttpClient = HttpClient()
    ..connectionTimeout = timeOut
    ..idleTimeout = timeOut;

  static HttpClient get _httpClient {
    HttpClient? client;
    assert(() {
      if (debugNetworkImageHttpClientProvider != null) {
        client = debugNetworkImageHttpClientProvider!();
      }
      return true;
    }());
    return client ?? _sharedHttpClient;
  }

  Future<T> get<T>({
    required String endpoint,
    required T Function(dynamic json) success,
  }) async {
    try {
      final request = await _httpClient.getUrl(Uri.parse(mUrl + endpoint));
      final response = await request.close();
      final mData = await response.transform(utf8.decoder).join("");

      final data = json.decode(mData);
      return success(data);
    } finally {}
  }
}
