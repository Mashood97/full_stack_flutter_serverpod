import 'package:dartz/dartz.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/verify_account_entity.dart';

import '../../../../core/error/response_error.dart';
import '../../../../core/usecase/usecase.dart';

import '../repositories/authentication_repository.dart';

class VerifyAccountUseCase extends UseCase<String, VerifyAccountEntity> {
  final AuthenticationRepository authenticationRepository;

  VerifyAccountUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<ResponseError, String>> call(VerifyAccountEntity params) async {
    return await authenticationRepository.verifyAccount(
        verifyAccountEntity: params);
  }
}
