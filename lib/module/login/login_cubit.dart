import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/local/constant.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  IconData icon=Icons.visibility_off;
  bool hidePass=true;
  void showPassword(){
    hidePass=!hidePass;
    if(hidePass){
      icon=Icons.visibility_off_rounded;
    }else{
      icon=Icons.remove_red_eye;
    }
    emit(ShowLoginPassWordState());
  }


  Future<void> signIn({required String email,required String password})async{
    emit(LoginLoadingState());
    await client.auth.signIn(email: email,password: password,).then((value) {
      emit(LoginSuccessState(value.error ==null? '':value.error!.message));
    }).catchError((error){
      emit(LoginErrorState());
    });
  }
}