import 'package:flutter/widgets.dart';

import 'dio_factory.dart';

class Config {
  Config._();

  /// API Config
  static const Duration timeout = Duration(seconds: 3);
  static const logNetworkRequest = true;
  static const logNetworkRequestHeader = true;
  static const logNetworkRequestBody = true;
  static const logNetworkResponseHeader = false;
  static const logNetworkResponseBody = true;
  static const logNetworkError = true;

  static bool isLoggedIn = false;

  static bool displayOnResponse = true;
  static bool displayOnError = true;
  static bool displayOnRequest = true;
}

enum APILog { cURL, request }
