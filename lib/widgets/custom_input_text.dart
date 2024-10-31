import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  const CustomInputText({
    super.key,
    required this.inputKey,
    required this.input,
  });

  final Key inputKey;
  final String input;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      key: inputKey, // Add the key to trigger animation
      duration: const Duration(milliseconds: 800),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        width: double.infinity,
        child: ListView(
          reverse: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: [
            Text(
              input,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
