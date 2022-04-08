abstract class SignUpStates{}

class SignUPInitialState extends SignUpStates{}

class ShowSignUpPasswordState extends SignUpStates{}

class ShowSignUpRePasswordState extends SignUpStates{}

class SuccessRegisterState extends SignUpStates{
  String? error;
  SuccessRegisterState(this.error);
}

class ErrorRegisterState extends SignUpStates{}

class SuccessCreateUserState extends SignUpStates{}

class ErrorCreateUserState extends SignUpStates{}

class ChangeProfileImageSuccessState extends SignUpStates{}

class ChangeProfileImageErrorState extends SignUpStates{}

class PutImageSuccessState extends SignUpStates{}

class PutImageErrorState extends SignUpStates{}

