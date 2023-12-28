import 'package:digipay_customer_core/api_factory/api_end_points.dart';
import 'package:flutter/material.dart';

import '../api_factory/api.dart';

class APIRepo {
  static loginWithPhone() => Api.request(
        path: ApiEndPoints.loginPhone,
        method: HttpMethod.post,
        params: {
          "dial_code": "+91",
          "phone_number": "84596565",
          "user_type": 2,
          "device_id": "123"
        },
      );
}
