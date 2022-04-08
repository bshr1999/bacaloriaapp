import 'package:arena/module/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import '../../shared/local/components.dart';
import '../login/login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title:  const Image(
          height: 50,
          image: AssetImage(
            'assets/images/AlfaBet-logo.png',
          ),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding:  const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Lottie.asset(
                    'assets/animation/delivery.json',
                  fit: BoxFit.fill
                ),
              ),
            ),
            Column(
              children: [
                loginButton(context: context, hexColor: HexColor('#4d0303'), text: "Login", onTap: () { navigateAndFinish(context: context, widget: LoginScreen());}),
                const SizedBox(height: 10.0,),
                loginButton(context: context, onTap: (){navigateAndFinish(context: context, widget: SignUp());}, hexColor: Colors.black, text: 'SignUp'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}