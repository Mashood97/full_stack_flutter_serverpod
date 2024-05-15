import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom_flutter/features/authentication/domain/entities/verify_account_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../main.dart';
import '../../domain/usecases/verify_account_usecase.dart';
import 'authentication_bloc.dart';

part 'verify_account_event.dart';

part 'verify_account_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  final VerifyAccountUseCase verifyAccountUseCase;

  VerifyAccountBloc({
    required this.verifyAccountUseCase,
  }) : super(const VerifyAccountInitial()) {
    on<VerifyButtonPressed>(
      _onVerification,
    );
  }

  final TextEditingController verification = TextEditingController();

  void onVerificationButtonPressed({required String email}) {
    add(
      VerifyButtonPressed(
          email: email, verificationCode: verification.text.trim()),
    );
  }

  Future<void> _onVerification(
      VerifyButtonPressed event, Emitter<VerifyAccountState> emit) async {
    emit(const VerifyAccountLoading());
    try {
      final response =
          await verifyAccountUseCase.authenticationRepository.verifyAccount(
        verifyAccountEntity: VerifyAccountEntity(
          email: event.email,
          verificationCode: event.verificationCode,
        ),
      );

      response.fold(
        (error) => emit(VerifyAccountFailure(error: error.toString())),
        (token) {
          authenticationBloc.add(LoggedIn(token: token));
          emit(const VerifyAccountInitial());
        },
      );
    } catch (e) {
      emit(VerifyAccountFailure(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    verification.dispose();
    return super.close();
  }
}
