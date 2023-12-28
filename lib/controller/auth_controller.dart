import 'package:digipay_customer_core/repository/api_repo.dart';
import 'package:flutter/material.dart';

class AuthController {
  const AuthController._();

  static loginPhone() => APIRepo.loginWithPhone();
}
