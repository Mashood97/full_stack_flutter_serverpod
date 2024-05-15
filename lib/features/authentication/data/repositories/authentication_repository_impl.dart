import 'package:dartz/dartz.dart';
import 'package:ecom_flutter/core/error/response_error.dart';
import 'package:ecom_flutter/features/authentication/data/datasources/remote/authentication_remote_data_source_repository.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/register_entity.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/verify_account_entity.dart';
import 'package:ecom_flutter/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSourceRepository
      authenticationRemoteDataSourceRepository;

  const AuthenticationRepositoryImpl(
      {required this.authenticationRemoteDataSourceRepository});

  @override
  Future<Either<ResponseError, String>> authenticate(
      {required LoginEntity loginEntity}) async {
    try {
      // if(loginEntity.username != null && loginEntity.password != null)
      // {
      final response =
          await authenticationRemoteDataSourceRepository.authenticate(
              email: loginEntity.username ?? "",
              password: loginEntity.password ?? "");
      if (response.isNotEmpty) {
        return Right(response);
      }
      return Left(
        ResponseError(errorStatus: "Something went wrong"),
      );
    } on ResponseError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ResponseError, bool>> hasToken() async {
    final response = await authenticationRemoteDataSourceRepository.hasToken();
    return Right(response);
  }

  @override
  Future<Either<ResponseError, bool>> logout() async {
    await authenticationRemoteDataSourceRepository.logout();
    return const Right(true);
  }

  @override
  Future<Either<ResponseError, bool>> persistToken(String token) async {
    await authenticationRemoteDataSourceRepository.persistToken(token);
    return const Right(true);
  }

  @override
  Future<Either<ResponseError, bool>> register(
      {required RegisterEntity registerEntity}) async {
    try {
      if (registerEntity.isValidData == true) {
        final response =
            await authenticationRemoteDataSourceRepository.register(
                email: registerEntity.email ?? "",
                userName: registerEntity.username ?? "",
                password: registerEntity.password ?? "");
        return Right(response);
      } else {
        return Left(
          ResponseError(errorStatus: "Please enter all form data"),
        );
      }
    } on ResponseError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ResponseError, String>> verifyAccount(
      {required VerifyAccountEntity verifyAccountEntity}) async {
    try {
      final response =
          await authenticationRemoteDataSourceRepository.verifyAccount(
              email: verifyAccountEntity.email,
              verificationCode: verifyAccountEntity.verificationCode);
      if (response.isNotEmpty) {
        return Right(response);
      }
      return Left(
        ResponseError(errorStatus: "Something went wrong"),
      );
    } on ResponseError catch (e) {
      return Left(e);
    }
  }
}
