import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/register_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/usecases/register_usecase.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({
    required this.registerUseCase,
  }) : super(const RegisterInitial()) {
    on<RegisterButtonPressed>(_registerUser);
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController userName = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  void callRegisterMethod() {
    add(
      RegisterButtonPressed(
          username: userName.text.toString(),
          password: password.text.toString().trim(),
          email: email.text.toString().trim()),
    );
  }

  Future<void> _registerUser(
      RegisterButtonPressed registerEvent, Emitter<RegisterState> emit) async {
    emit(const RegisterLoading());
    final response = await registerUseCase.authenticationRepository.register(
      registerEntity: RegisterEntity(
          email: registerEvent.email,
          password: registerEvent.password,
          username: registerEvent.username),
    );
    response.fold(
        (error) => emit(
              RegisterFailure(
                error: error.errorStatus,
              ),
            ), (success) {
      if (success) {
        emit(
          RegisterSuccess(
              message: "Registered Successfully", isRegistered: success),
        );
      } else {
        emit(
          const RegisterFailure(
            error: "An Error occured, Please try again later",
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    email.dispose();
    password.dispose();
    userName.dispose();
    confirmPassword.dispose();
    return super.close();
  }
}
