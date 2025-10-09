import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required,
    this.onTap,
    this.backColor,
    this.frontColor,
    this.fontSize,
  });

  final String text;
  final void Function()? onTap;
  final Color? backColor;
  final Color? frontColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 160,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.5), color: backColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: frontColor,
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }
}
