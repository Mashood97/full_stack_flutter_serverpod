import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/persist_token_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../domain/usecases/has_token_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

/* We used Hydrated Bloc because we don't want our app to share Initial state (AuthenticationUninitialized) state again and again when we refresh the page on web/desktop platforms
* instead it will return the last saved status i.e if authenticated then it will return status as AuthenticationAuthenticated else AuthenticationUnauthenticated */
class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  // final AuthenticationRepository authRepository;
  final HasTokenUseCase hasTokenUsecase;
  final PersistTokenUseCase persistTokenUseCase;
  final LogoutUseCase logoutUseCase;

  AuthenticationBloc({
    required this.hasTokenUsecase,
    required this.persistTokenUseCase,
    required this.logoutUseCase,

  }) : super(const AuthenticationUninitialized()) {
    on<AuthenticationEvent>(_onEvent);
  }

  Future<void> _onEvent(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    if (event is AppStarted) {
      final hasToken = await hasTokenUsecase.authenticationRepository.hasToken();

      hasToken.fold(
        (error) => emit(
          const AuthenticationUnauthenticated(),
        ),
        (success) => emit(
          success == true
              ? const AuthenticationAuthenticated()
              : const AuthenticationUnauthenticated(),
        ),
      );
    }

    if (event is LoggedIn) {
      emit(const AuthenticationLoading());

      final response = await persistTokenUseCase.authenticationRepository.persistToken(event.token);
      response.fold(
        (_) => emit(
          const AuthenticationUnauthenticated(),
        ),
        (success) => emit(
          success
              ? const AuthenticationAuthenticated()
              : const AuthenticationUnauthenticated(),
        ),
      );
    }

    if (event is LoggedOut) {
      emit(const AuthenticationLoading());

      final response = await logoutUseCase.authenticationRepository.logout();
      response.fold(
        (_) => emit(
          const AuthenticationUnauthenticated(),
        ),
        (success) => emit(success
            ? const AuthenticationUnauthenticated()
            : const AuthenticationAuthenticated()),
      );
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      bool isAuthenticated = json['data'];
      return isAuthenticated
          ? const AuthenticationAuthenticated()
          : const AuthenticationUnauthenticated();
    }

    return const AuthenticationUninitialized();
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return {
      "data": state is AuthenticationAuthenticated ? true : false,
    };
  }
}
