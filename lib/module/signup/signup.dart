import 'package:arena/module/signup/signup_cubit.dart';
import 'package:arena/module/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/local/components.dart';
import '../login/login.dart';


// ignore: must_be_immutable
class SignUp extends StatelessWidget {

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var rePasswordController=TextEditingController();
  var formKey=GlobalKey<FormState>();


  SignUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SignUpCubit(),
      child: BlocConsumer<SignUpCubit,SignUpStates>(
        listener: (BuildContext context, state) {
        if(state is SuccessRegisterState){
          if(state.error==''){
            navigateAndFinish(context: context, widget: LoginScreen());
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit=SignUpCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage(
                          'assets/images/AlfaBet-logo.png',
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: textForm(
                          labelText: 'Enter your name',
                          type: TextInputType.text,
                          prefixIcon: const Icon(
                            Icons.person_add_rounded,
                          ),
                          controller: nameController,
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: textForm(
                          labelText: 'Enter Email',
                          type: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          controller: emailController,
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'required';
                            }
                            if(state is SuccessRegisterState){
                              if(state.error=='Expected a value of type \'Map<String, dynamic>\', but got one of type \'Null\''){
                                return 'أدخل بريد الكتروني صالح';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: textForm(
                          obscureText: cubit.hidePass,
                          labelText: 'Enter Password',
                          type: TextInputType.visiblePassword,
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.showPassword();
                            },
                            icon: Icon(cubit.passIcon),
                          ),
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'required';
                            }
                            if(value.length+1<6){
                              return 'كلمة المرورة قصيرة';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: textForm(
                          obscureText: cubit.hideCheckPass,
                          labelText: 'reEnter Password',
                          type: TextInputType.visiblePassword,
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.showCheckPassword();
                            },
                            icon:  Icon(cubit.checkPassIcon),
                          ),
                          controller: rePasswordController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'required';
                            }else if(value!=passwordController.text){
                              return 'rePassword Error';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      loginButton(
                          context: context,
                          onTap: (){
                            if(formKey.currentState!.validate()){
                             cubit.signUp(email: emailController.text, password: passwordController.text);
                            }
                         },
                        hexColor: HexColor('#4d0303'),
                        text: "SignUp"),
                      const SizedBox(height: 10.0,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'already have an account ?',
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
                              },
                              child: Text(
                                'Login',
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
