import 'package:arena/module/signup/signup.dart';
import 'package:arena/shared/local/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../home/home_screen.dart';
import 'login_cubit.dart';
import 'login_state.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {


  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {
          if(state is LoginSuccessState){
            if(state.error==''){
              navigateAndFinish(context: context, widget: const HomeScreen());
            }else if(state.error=='Email not confirmed'){
             showDialog(context: context, builder: (BuildContext context) {
               return AlertDialog(
                 content: Column(
                   mainAxisSize:MainAxisSize.min,
                   children: [
                     Wrap(
                       children: const [
                         Text('الرجاء تأكيد البريد الالكتروني من خلال النقر على الرابط المبعوث في الرسالة'),
                       ],
                     ),
                     const SizedBox(height: 10),
                     loginButton(context: context, onTap: (){
                       if(state.error!=''){
                         navigateAndFinish(context: context, widget: const HomeScreen());
                       }
                     }, hexColor: Colors.black, text: 'تم التحقق')
                   ],
                 ),
               );
             });
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage(
                            'assets/images/AlfaBet-logo.png',
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 8.0,),
                            textForm(
                                type: TextInputType.emailAddress,
                                prefixIcon: const Icon(
                                  Icons.supervised_user_circle_outlined,
                                ),
                                controller: emailController,
                                validator: (value){
                                  if(value!.isEmpty) {
                                    return 'required';
                                  }
                                  if(state is LoginSuccessState){
                                    if(state.error=='Invalid login credentials'){
                                      return 'خطأ في الايميل او كلمة السر';
                                    }else{
                                      return state.error;
                                    }
                                  }
                                  return null;
                                },
                                hintText: 'Email'
                            ),
                            const SizedBox(height: 30,),
                            const Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 8.0,),
                            textForm(
                              obscureText: LoginCubit.get(context).hidePass,
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: (){
                                  LoginCubit.get(context).showPassword();
                                },
                                icon: Icon(
                                  LoginCubit.get(context).icon,
                                ),
                              ),
                              type: TextInputType.visiblePassword,
                              prefixIcon: const Icon(
                                  Icons.lock
                              ),
                              controller: passwordController,
                              validator: (value){
                                if(value!.isEmpty) {
                                  return 'required';
                                }
                                if(state is LoginSuccessState){
                                  if(state.error=='Invalid login credentials'){
                                    return 'خطأ في الأيميل او كلمة السر';
                                  }else{
                                    return state.error;
                                  }
                                }
                                return null;
                              }
                            ),
                            const SizedBox(height: 40,),
                            if (state is LoginLoadingState)
                              const Center(child: CircularProgressIndicator(color: Colors.black,)),
                            if (state is !LoginLoadingState)
                            loginButton(context: context, onTap: (){
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).signIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }}, hexColor: HexColor('#4d0303'), text: 'Submit'),
                            const SizedBox(height: 10.0,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  const Text(
                                    'Don\'t have an account ?',
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      navigateTo(context: context, widget: SignUp());
                                    },
                                    child: Text(
                                      'Signup',
                                      style: TextStyle(
                                        color: HexColor('#4d0303'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}