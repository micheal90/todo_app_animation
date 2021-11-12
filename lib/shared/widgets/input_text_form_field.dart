import 'package:flutter/material.dart';
import 'package:todo_animated_app/shared/theme.dart';

class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    Key? key,
    this.controller,
    this.initialValue,
    required this.title,
    this.lebel,
    this.hint,
    this.suffixIcon,
    this.type,
    this.onSave,
    this.autofocus=false,
    this.validator,
    this.onTap,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? initialValue;
  final String? lebel;
  final String? hint;
  final String title;
  final bool autofocus;
  final Widget? suffixIcon;
  final TextInputType? type;
  final Function(String?)? onSave;
  final String? Function(String?)? validator;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: heading6Style,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText: lebel,
              hintText: hint,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
          readOnly: suffixIcon == null ? false : true,
          autofocus: autofocus,
          initialValue: initialValue,
          keyboardType: type,
          controller: controller,
          onSaved: onSave,
          validator: validator,
          onTap: onTap,
        ),
      ],
    );
  }
}
