import 'dart:developer';

import 'package:flutter/foundation.dart';

class PBLog {
  PBLog(var value, {String? tag}) {
    if (kDebugMode) {
      log("=====> ${value.toString()} <=====", name: tag ?? "");
    }
  }
}
