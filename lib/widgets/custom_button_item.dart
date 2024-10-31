import 'package:flutter/material.dart';

class CustomButtonItem extends StatelessWidget {
  const CustomButtonItem({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.onTap,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(70),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(70),
            right: Radius.circular(70),
          ),
          color: color ?? Colors.grey.shade800,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 27,
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
