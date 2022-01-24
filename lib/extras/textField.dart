import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final int? maxLines;
  final Color borderColor;
  final Color color;
  final TextStyle? style;
  final bool obscure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final Color hintColor;
  const CustomTextField(
      {Key? key,
      this.hintText,
      this.controller,
      this.keyboard,
      this.maxLines,
      this.borderColor = Colors.transparent,
      this.color = Colors.transparent,
      this.style,
      this.obscure = false,
      this.suffixIcon,
      this.textAlign = TextAlign.justify,
      this.hintColor = Colors.grey,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(
      //width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          color: color,
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        obscureText: obscure,
        maxLines: maxLines,

        keyboardType: keyboard,
        controller: controller,
        textAlign: textAlign,
        style: style,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
        ),
        // validator: MultiValidator([
        //   EmailValidator(errorText: ""),
        //   RequiredValidator(errorText: ""),
        // ]),
      ),
    );
  }
}
