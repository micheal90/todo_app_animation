import 'package:flutter/material.dart';
import 'package:todo_animated_app/shared/size_config.dart';
import 'package:todo_animated_app/shared/theme.dart';

class BottomSheetOption extends StatelessWidget {
  const BottomSheetOption({
    Key? key,
    required this.lebel,
    this.color,
    required this.onTap,
  }) : super(key: key);

  final String lebel;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth* 0.9,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: color != null ? color! : Colors.grey,
            width: 2,
          ),
          color: color,
        ),
        child: Center(
          child: Text(
            lebel,
            style: color != null
                ? heading6Style.copyWith(color: Colors.white)
                : heading6Style,
          ),
        ),
      ),
    );
  }
}
