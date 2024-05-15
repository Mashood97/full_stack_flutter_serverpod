import 'package:dartz/dartz.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/register_entity.dart';

import '../../../../core/error/response_error.dart';
import '../../../../core/usecase/usecase.dart';

import '../repositories/authentication_repository.dart';

class RegisterUseCase extends UseCase<bool, RegisterEntity> {
  final AuthenticationRepository authenticationRepository;

  RegisterUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<ResponseError, bool>> call(RegisterEntity params) async {
    return await authenticationRepository.register(registerEntity: params);
  }
}
