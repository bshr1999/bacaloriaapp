import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget textForm({
  required TextInputType type,
  String? hintText,
  String? labelText,
  required Widget prefixIcon,
  Widget? suffixIcon,
  required TextEditingController controller,
  required FormFieldValidator<String> validator,
  bool obscureText=false
})=>TextFormField(
  autofocus: true,
  cursorColor: HexColor('#4d0303'),
  obscureText: obscureText,
  controller: controller,
  keyboardType: type,
  decoration: InputDecoration(
    prefixIconColor: HexColor('#4d0303'),
    suffixIconColor: HexColor('#4d0303'),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: HexColor('#4d0303'),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: HexColor('#4d0303')),
    ),

    hintText: hintText,
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  ),
  validator: validator,
);

Widget loginButton({
  required context,
  required GestureTapCallback onTap,
  required Color hexColor,
  required String text
})=>Container(
  width: double.infinity,
  decoration: BoxDecoration(
    color: hexColor,
    borderRadius: BorderRadius.circular(10.0),
  ),
  child:   TextButton(
    onPressed: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
    ),
  ),
);

dynamic navigateTo({required context,required Widget widget})=>
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>widget));

dynamic navigateAndFinish({required context,required Widget widget})=>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>widget));

