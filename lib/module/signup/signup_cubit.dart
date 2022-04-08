import 'package:arena/shared/local/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(SignUPInitialState());

  static SignUpCubit get(context)=>BlocProvider.of(context);

  IconData passIcon=Icons.visibility_off;
  bool hidePass=true;
  void showPassword(){
    hidePass=!hidePass;
    if(hidePass){
      passIcon=Icons.visibility_off_rounded;
    }else{
      passIcon=Icons.remove_red_eye;
    }
    emit(ShowSignUpPasswordState());
  }

  IconData checkPassIcon=Icons.visibility_off;
  bool hideCheckPass=true;
  void showCheckPassword(){
    hideCheckPass=!hideCheckPass;
    if(hideCheckPass){
      checkPassIcon=Icons.visibility_off_rounded;
    }else{
      checkPassIcon=Icons.remove_red_eye;
    }
    emit(ShowSignUpRePasswordState());
  }

  SupabaseClient client = SupabaseClient(supabaseUrl, supabaseKey);

  signUp({required String email,required String password})async{
    await client.auth.signUp(email,password).then((value) {
      emit(SuccessRegisterState(value.error ==null? '':value.error!.message));
    }).catchError((error){
      // ignore: avoid_print
      print(error.toString());
      emit(ErrorRegisterState());
    });
  }
}