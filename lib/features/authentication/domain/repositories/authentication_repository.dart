import 'package:dartz/dartz.dart';
import 'package:ecom_flutter/core/error/response_error.dart';

import '../entities/login_entity.dart';
import '../entities/register_entity.dart';
import '../entities/verify_account_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<ResponseError, String>> authenticate(
      {required LoginEntity loginEntity});

  Future<Either<ResponseError, bool>> register(
      {required RegisterEntity registerEntity});

  Future<Either<ResponseError, String>> verifyAccount(
      {required VerifyAccountEntity verifyAccountEntity});

  Future<Either<ResponseError, bool>> logout();

  Future<Either<ResponseError, bool>> persistToken(String token);

  Future<Either<ResponseError, bool>> hasToken();
}
