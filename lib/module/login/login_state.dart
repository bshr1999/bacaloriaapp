abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class ShowLoginPassWordState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  String? error;
  LoginSuccessState(this.error);
}

class LoginLoadingState extends LoginStates{}

class LoginErrorState extends LoginStates{}