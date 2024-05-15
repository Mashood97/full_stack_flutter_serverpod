import 'package:dartz/dartz.dart';

import '../../../../core/error/response_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repository.dart';

class PersistTokenUseCase extends UseCase<void, String> {
  final AuthenticationRepository authenticationRepository;

  PersistTokenUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<ResponseError, void>> call(String params) async {
    return await authenticationRepository.persistToken(params);
  }
}
