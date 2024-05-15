import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_flutter/features/authentication/data/datasources/remote/authentication_remote_data_source_repository.dart';
import 'package:ecom_flutter/features/authentication/data/datasources/remote/authentication_remote_data_source_repository_impl.dart';
import 'package:ecom_flutter/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:ecom_flutter/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/has_token_usecase.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/login_usecase.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/persist_token_usecase.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/register_usecase.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/verify_account_usecase.dart';
import 'package:ecom_flutter/features/authentication/presentation/manager/register_bloc.dart';
import 'package:ecom_flutter/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import '../../core/platform/network_information.dart';
import '../../features/authentication/presentation/manager/authentication_bloc.dart';
import '../../features/authentication/presentation/manager/login_bloc.dart';
import '../../features/authentication/presentation/manager/verify_account_bloc.dart';
import '../internet_checker/network_bloc.dart';
import '../local_storage/local_storage.dart';
import '../localizations/language_cubit/language_cubit.dart';

final getItInstance = GetIt.instance;

void initializeDependencies() {
  _initializeBlocsAndCubits();
  _initializeRepositories();
  _initializeUseCases();
  _initializeExternalPackages();
}

void _initializeBlocsAndCubits() {
  getItInstance.registerLazySingleton(
    () => NetworkBloc(),
  );

  getItInstance.registerFactory<LanguageCubit>(
    () => LanguageCubit(),
  );

  getItInstance.registerFactory(
    () => AuthenticationBloc(
      persistTokenUseCase: getItInstance(),
      logoutUseCase: getItInstance(),
      hasTokenUsecase: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => LoginBloc(
      loginUseCase: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => RegisterBloc(
      registerUseCase: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => VerifyAccountBloc(
      verifyAccountUseCase: getItInstance(),
    ),
  );
}

void _initializeRepositories() {
  getItInstance.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationRemoteDataSourceRepository: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSourceRepository>(
    () => AuthenticationRemoteDataSourceRepositoryImpl(
      authController: getItInstance(),
    ),
  );

  final EmailAuthController emailAuthController =
      EmailAuthController(client.modules.auth);

  getItInstance.registerLazySingleton(() => emailAuthController);
}

void _initializeUseCases() {
  getItInstance.registerLazySingleton(
    () => HasTokenUseCase(
      authenticationRepository: getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton(
    () => LoginUseCase(
      authenticationRepository: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton(
    () => LogoutUseCase(
      authenticationRepository: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton(
    () => PersistTokenUseCase(
      authenticationRepository: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton(
    () => RegisterUseCase(
      authenticationRepository: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton(
    () => VerifyAccountUseCase(
      authenticationRepository: getItInstance(),
    ),
  );
}

void _initializeExternalPackages() {
  //local storage
  const storage = FlutterSecureStorage();
  getItInstance.registerLazySingleton(() => storage);

  final localStorage = LocalStorage();
  getItInstance.registerLazySingleton(() => localStorage);
  getItInstance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      networkConnectionCheck: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton(() => Connectivity());
}
