import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:ecom_flutter/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ecom_flutter/features/authentication/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../main.dart';

import 'authentication_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({
    required this.loginUseCase,
  }) : super(const LoginInitial()) {
    on<LoginEvent>(_onEvent);
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  Future<void> close() {
    email.dispose();
    password.dispose();
    loginFormKey.currentState?.reset();
    return super.close();
  }

  void loginButtonCalled() {
    add(
      LoginButtonPressed(
        username: email.text.trim(),
        password: password.text.trim(),
      ),
    );
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginButtonPressed) {
      emit(const LoginLoading());
      try {
        final LoginEntity loginEntity =
            LoginEntity(username: event.username, password: event.password);
        final response =
            await loginUseCase.authenticationRepository.authenticate(
          loginEntity: loginEntity,
        );

        response.fold(
          (error) => emit(LoginFailure(error: error.toString())),
          (token) {
            authenticationBloc.add(LoggedIn(token: token));
            emit(const LoginInitial());
          },
        );
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    }
  }
}
