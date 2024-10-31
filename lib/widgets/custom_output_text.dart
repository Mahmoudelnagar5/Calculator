import 'package:flutter/material.dart';

class CustomOutputText extends StatelessWidget {
  const CustomOutputText({
    super.key,
    required this.output,
  });

  final String output;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: Text(
        output,
        style: TextStyle(
          fontSize: 35,
          color: Colors.white.withOpacity(.7),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
