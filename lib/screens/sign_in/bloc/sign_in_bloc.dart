import 'package:bloc/bloc.dart';
import 'package:checkup/core/services/auth_service.dart';
import 'package:checkup/core/services/validation_service.dart';
import 'package:flutter/material.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isButtonEnabled = false;
  SignInBloc() : super(SignInInitial()) {
    on<OnTextChangeEvent>((event, emit) {
      if (isButtonEnabled != _checkIfSignInButtonEnabled()) {
        isButtonEnabled = _checkIfSignInButtonEnabled();
        emit(SignInButtonEnableChangedState(isEnabled: isButtonEnabled));
      }
    });
    on<SignInTappedEvent>((event, emit) async {
      if (_checkValidatorsOfTextField()) {
        try {
          emit(LoadingState());
          await AuthService.signIn(
              emailController.text, passwordController.text);
          emit(NextTabBarPageState());
        } catch (e) {
          emit(ErrorState(message: e.toString()));
        }
      } else {
        emit(ShowErrorState());
      }
    });
    on<ForgotPasswordTappedEvent>(
      (event, emit) {
        emit(NextForgotPasswordPageState());
      },
    );
    on<SignUpTappedEvent>(
      (event, emit) {
        emit(NextSignUpPageState());
      },
    );
  }
  bool _checkIfSignInButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool _checkValidatorsOfTextField() {
    return ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text);
  }
}
