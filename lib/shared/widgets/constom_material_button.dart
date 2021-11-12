import 'package:flutter/material.dart';
import 'package:todo_animated_app/shared/theme.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      color: KprimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: onPressed,
      child: Text(
        text,
        style: title1Style.copyWith(color: Colors.white),
      ),
    );
  }
}
