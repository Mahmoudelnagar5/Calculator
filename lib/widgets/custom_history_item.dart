import 'package:flutter/material.dart';

import '../models/history_model.dart';

class CustomHistoryItem extends StatelessWidget {
  final HistoryModel history;
  final VoidCallback onTap;

  const CustomHistoryItem({
    super.key,
    required this.history,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        history.input,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        textAlign: TextAlign.right,
      ),
      subtitle: Text(
        history.output,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
